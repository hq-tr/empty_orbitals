include("/home/trung/_qhe-julia/FQH_state_v2.jl")
using .FQH_states

include("/home/trung/_qhe-julia/Misc.jl")
using .MiscRoutine

using ArgMacros

function main()
	@inlinearguments begin
		@argumentrequired String filename "--filename" "-f"
		@argumentrequired Int k "--n_empty" "-k"
		@argumentflag decimal "--decimal"
		@argumentoptional Int No "--n_orb" "-o"
		@argumentflag nonormalization "--no-normalization"
		@argumentflag basisonly "--basis-only"
	end

	# Validate input
	if !isfile(filename)
		println("File not found")
		return
	end

	@assert k > 0 "Number of empty orbitals 'n_empty' must be a positive integer"

	if basisonly 
		decimal = true
		nonormalization = true
	end

	if decimal && No == nothing
		println("For input file of decimal format, the number of orbitals must be specified.")
		return
	end

	# Read file
	if basisonly
		state = readbasis(filename,No)
	elseif decimal
		state = readwfdec(filename,No)
	else
		state = readwf(filename)
	end



	if basisonly
		new_basis = BitVector[]
		for basis in state.basis
			if count(basis[1:k]) == 0
				push!(new_basis,basis)
			end
		end
		new_state = FQH_state(new_basis)
	else
		new_coefs = Float64[]
		new_basis = BitVector[]
		for (basis,coef) in zip(state.basis,state.coef)
			if count(basis[1:k]) == 0
				push!(new_basis,basis)
				push!(new_coefs,coef)
			end
		end
		if !nonormalization
			new_state = wfnormalize(FQH_state(new_basis,new_coefs))
		end
	end

	
	printwf(new_state;fname="$(filename)_empty_k_$(k)")
end

@time main()