# Wheeled Mobile Robot Kinematic Modelling (wmrKinMod)

## Project Overview

`wmrKinMod` is a MATLAB support tool for the kinematic modelling of wheeled mobile robots (WMRs). It is intended to help students verify the intermediate steps and final results of a kinematic model derived by hand, following the conventions introduced in the Mobile Robots course.

Given a robot description file, the program computes and displays the main matrices and quantities involved in the modelling process, including the Jacobian-related matrices and the complete kinematic model. It also computes a basis for the kernel of \(C_1^*\), which can optionally be modified during execution.

> **Note:** This software is an educational support tool. It is not intended to replace the course material or interaction with the instructor. The program files are distributed in MATLAB `.p` format and are not provided as editable `.m` source files.

## Repository Structure

```text
wmrKinMod/
├── wmrKinMod.p                 # Main MATLAB program
├── parseToken.p                # Parsing utility
├── readRobotDescription.p      # Reads a robot description file
├── robots/
│   └── robot_2_0.wmr           # Example wheeled mobile robot description
├── readme.txt                  # Original, detailed documentation
└── README.md                   # Project overview and quick-start guide
```

## Requirements

- MATLAB R2019b (the version used to develop and test the software).
- MATLAB **Symbolic Math Toolbox**.

Other MATLAB versions may work, but compatibility is not guaranteed.

## Getting Started

1. Open MATLAB and set the `wmrKinMod` directory as the current folder, or add it to the MATLAB path.
2. Create or edit a robot description file in the `robots/` directory, using the `.wmr` extension. The file `robots/robot_2_0.wmr` is provided as an example.
3. Clear the MATLAB workspace before running the program. The tool uses workspace variables, so leftover variables from previous computations may interfere with execution. The program intentionally does not clear the workspace automatically.
4. Run the main program from the MATLAB Command Window:

   ```matlab
   wmrKinMod
   ```

5. Follow the prompts. During execution, the program may ask whether you want to modify the computed basis `Sigma`. Press **Enter** to keep it unchanged, or enter a valid MATLAB assignment if a modification is needed.
6. Inspect the displayed results and, if necessary, examine additional variables in the MATLAB workspace.

For many matrices, a corresponding LaTeX representation is also provided in a variable whose name ends in `_latex` (for example, `J1_latex`). If a LaTeX variable is not available, MATLAB's `latex()` function can be used on the corresponding symbolic variable or matrix.

## Robot Description Files (`.wmr`)

Robot configurations are defined by text files stored in the `robots/` directory. Each file must use the `.wmr` extension and follow the format illustrated by `robots/robot_2_0.wmr`.

The parameter table must contain the following header, in this exact order:

```text
R  L  alpha  d  beta  gamma  phi
```

The header is compulsory. The `psi` column is not included because it is computed internally by the program. Spaces can be used freely to align the columns, and comments start with `%` and continue to the end of the line.

The accepted values are restricted:

- **`R`**: named constants (for example, `r`, `r1`, `r_1`).
- **`L`**: named constants or `0`.
- **`alpha`**: one of the supported constant angles: `0`, `pi`, `-pi`, `pi/2`, `-pi/2`, `pi/4`, `-pi/4`, `3*pi/4`, `-3*pi/4`.
- **`d`**: named constants or `0`.
- **`beta`**: `0` or an affine expression in a single variable (for example, `beta_1` or `-beta_1 + pi/2`).
- **`gamma`**: one of the supported constant angles listed for `alpha`.
- **`phi`**: variable names representing the relevant configuration variables.

Some names are reserved for internal use (such as `beta`, `Sigma`, `D`, and `E`) and must not be used in the parameter table. Avoid names that conflict with MATLAB functions or constants, such as `sin`, `cos`, or `pi`.

## Main Modelling Workflow

The recommended workflow is to perform the theoretical calculations by hand and use the program to check the results at key stages:

1. Determine `q` and compute `J1`, `J2`, `C1`, `C2`, and `C1*`.
2. Compute `rank(C1*)`, `delta_m`, and a basis `Sigma` of the kernel of `C1*`.
3. Derive the complete kinematic model `S(q)`.

The program can be used to verify intermediate quantities as well as the final model.

## Troubleshooting

- **Unexpected results or errors:** clear the MATLAB workspace before running the program.
- **Robot description is not accepted:** check the exact header, the number and order of columns, and the allowed expressions for each column.
- **Variable-name errors:** make sure that no reserved names or MATLAB function names are used in the parameter table.
- **Unsupported angle expressions:** use only the constant angles allowed for `alpha` and `gamma`.
- **LaTeX output is missing:** if the symbolic matrix exists in the workspace, try `latex(matrix_name)`.

## Additional Documentation

For more detailed instructions, parameter-format rules, usage notes, and troubleshooting information, consult the original documentation file **[`readme2`](readme2)**.

## Credits

The software documentation identifies **Gaëtan Garcia (École Centrale de Nantes)** as the author/contact person. For questions or bug reports, the original documentation provides the following contact address: `gaetan.garcia@ec-nantes.fr`.
