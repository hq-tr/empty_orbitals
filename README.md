# Empty Orbitals

## Introduction and Preamble
This is a short script that projects/truncates a given many-body state into a subspace with the first k orbitals empty. 

The script will require the [QHE_Julia](https://github.com/hq-tr/QHE_Julia) library. Before using, the preamble part of the script to point to the correct script where _QHE_Julia_ is installed.

## Usage
All the parameter tags can be shown with 

```
julia empty_orbitals.jl -h
```

The script requires an input file, which may be of binary or decimal format. If the file is in decimal format, the `--decimal` tag should be used followed by `--n_orb` (or `-o`) to indicate the number of orbital. The number of empty orbitals is specified with tag `--n_empty` (or `-k`). 

The output file has the format `"$(input_file_name)_empty_k_$(k)`.