v 1.01. Fixes a bug in the determination of delta_s, and hence in the 
        dimension of S(q).

                              Warning
                              
This software is intended as a support tool for students working on the
kinematic modelling part of the Mobile Robots course. It follows the
conventions introduced in the lectures, which are not repeated here.

This program is not meant to replace interaction with the instructor.
If the tool does not help, or if you prefer to proceed differently, you
are encouraged to send your work by email for feedback.

                               Contact

Gaëtan Garcia
Ecole Centrale de Nantes
gaetan.garcia@ec-nantes.fr


                       How to use the software.

The program has been developed and tested with Matlab 2019b and requires
the Symbolic Math Toolbox.

The intended workflow is to solve exercises by hand and use the program
to verify intermediate and final results. The following checkpoints are
recommended:

  1. After determining q and computing J1, J2, C1, C2, C1*.
  2. After computing rank(C1*), delta_m, and a basis Sigma of the kernel
     of C1*.
  3. After deriving the full kinematic model S(q).

Step 1: Enter the parameter table in a file located in the "robots"
directory, with extension ".wmr" (wheeled mobile robot). See details below.

Step 2: Run the program. Since the program relies on variables in the
workspace, it is recommended to clear the workspace before execution.
Residual variables from previous runs may interfere with the computation.
The program does not perform this step automatically in order to avoid
deleting unrelated user data.

Step 3 (optional): During execution, the program computes a basis Sigma
of the kernel of C1*. You are given the opportunity to modify this basis.

If no modification is required, simply press ENTER.

Otherwise, enter a valid MATLAB instruction of the form:
    Sigma = <expression involving Sigma and workspace variables>

Example:
    Sigma = Sigma*sin(beta_1s)
(assuming beta_1s is an existing variable)

Step 4: Use the results to check your calculations. The program displays
the main matrices (J1, C1, etc.). Additional variables can be inspected
from the workspace. To display one, type its name in the command window.

For most matrices, a LaTeX representation is also available in variables
named matrix_name_latex (e.g. J1_latex).


               Editing the ".wmr" robot description file 

1. File format rules

Follow the example given in file "robot_2_0.wmr".

• Comments start with a % as in a Matlab code and extend to end of line.

• The table format is defined by the following header (order imposed)

   R  L    alpha     d    beta     gamma    phi

This header line is compulsory. Note that column psi is not included:
it is computed internally by the program.

• Any number of spaces may be used between columns. This can be used to
visually align the table.

2. Column constraints

     • Column R: only named constants (r, r1, r_1, r_l,...)
     • Column L: named constants (a, b...) or 0.
     • Column alpha: only constant angles 
          0, pi, -pi, pi/2, -pi/2, pi/4, -pi/4, 3*pi/4, -3*pi/4.
     • Column d: named constants or 0.
     • Column beta: 0 or an affine expression in a single variable
           (e.g. beta_1, -beta_1 + pi/2)
     • Column gamma: only constant angles 
          0, pi, -pi, pi/2, -pi/2, pi/4, -pi/4, 3*pi/4, -3*pi/4.
     • Column phi: variable names (phi_1, q_r, q_l, phi_l...)

3. Reserved names

Certain names are reserved for internal use (e.g. beta, Sigma, D, E, etc.)
and must not be used in the parameter table. An error will be raised if
such names are detected.

4. Naming recommendations:

Choose names that keep expressions readable. Avoid names that conflict
with standard mathematical functions (e.g. sin, cos) or constants such as
pi. Short names (e.g. a, b, c) are recommended for constants.

5. Scope of the tool

Only a restricted set of angles is allowed in columns alpha and gamma.
This is consistent with the purpose of the program, which is to support
hand calculations at exam level. More general inputs would lead to
expressions that are unnecessarily complex.

6. Common issues

• Using reserved variable names (e.g. beta, Sigma)
• Not clearing the workspace before execution
• Entering unsupported expressions in column beta
• Incorrect number of columns in the parameter table


                                Q&A

• Why is the program distributed as a non-editable ".p" file rather than
  a standard ".m" source?

To prevent the distribution of modified versions of the program, which
could lead to incorrect results being circulated among students.


• How do I report a bug or ask a question?

Contact: gaetan.garcia@ec-nantes.fr


• I have trouble determining the parameter table for a given robot.

This is not a software issue. As part of the course, you may send your
work for feedback.

• How do I get the latex code of a variable or matrix ?

If it is not listed as matrix_name_latex but matrix_name exists, just
execute latex(matrix_name) in the command line.


• How do I obtain the LaTeX code of a variable or matrix?

If a variable matrix_name exists but matrix_name_latex is not provided,
you can generate it using:
    latex(matrix_name)


• Why is motorization not covered?

Motorization involves not only computation but also interpretation and
design considerations. It is beyond the scope of this tool.