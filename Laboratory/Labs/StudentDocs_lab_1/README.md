# Mobile Robot Localization – Lab 1

## Overview

This project implements and evaluates a mobile-robot localization system based on an **Extended Kalman Filter (EKF)**. The robot uses wheel-encoder odometry for motion prediction and a magnetic sensor (an array of reed switches) to obtain external position measurements from magnets arranged on a regular grid.

The objective of the lab is to complete the motion model, configure the noise covariance matrices, implement the missing parts of the localization algorithm, and study how the EKF behaves under different trajectories and parameter settings.

## Project Structure

```text
StudentDocs_lab_1/
├── data/                         # Recorded robot datasets
│   ├── circles.txt
│   ├── diagonal45degrees.txt
│   ├── line1magnet.txt
│   ├── line2magnets.txt
│   ├── oneloop.txt
│   └── twoloops.txt
├── DefineVariances.m              # EKF covariance and threshold parameters
├── EvolutionModel.p               # Provided MATLAB p-code reference
├── ExtractMeasurements.m           # Converts raw sensor data into measurements
├── MagnetLoc.m                    # Main EKF localization program
├── MyEvoModel.m                   # Student motion-model implementation
├── PlotRawData.m                  # Odometry-only path and raw-data plots
├── PlotResults.m                  # EKF result visualization
├── PreprocessData.m               # Data preprocessing
├── RobotAndSensorDefinition.m      # Robot, sensor and magnet-grid parameters
├── LogData.m                      # Stores data for plotting
└── ...                            # Supporting files, logs, videos and lab material
```

## Method

The localization algorithm follows two main steps:

1. **Prediction:** wheel encoder increments are converted into linear and angular motion. The robot pose is propagated using the differential-drive motion model, while the state covariance is updated to account for process and odometry uncertainty.
2. **Measurement update:** when the magnetic sensor detects one or more magnets, the corresponding measurements are expressed in the robot reference frame. Candidate magnets on the known grid are identified, and the innovation is evaluated using the Mahalanobis distance. Measurements that pass the threshold are used to correct the estimated pose and covariance.

The robot state is:

```text
X = [x, y, theta]'
```

where `x` and `y` are the robot position and `theta` is its heading.

## Main MATLAB Files

- **`MagnetLoc.m`** – main program implementing the EKF localization loop.
- **`EvolutionModel.m`** – motion/evolution model called by `MagnetLoc.m`. The lab requires students to implement this function. `MyEvoModel.m` contains the motion-model implementation in this project; make sure its filename and function name match the `EvolutionModel` call before running the main program.
- **`DefineVariances.m`** – defines the initial pose covariance, measurement-noise covariance, odometry/process-noise parameters, and Mahalanobis-distance threshold.
- **`RobotAndSensorDefinition.m`** – defines the differential-drive robot, magnetic sensor and magnet-grid characteristics.
- **`PlotRawData.m`** – displays the odometry-based trajectories and sensor-related data before running the EKF.
- **`PlotResults.m`** – displays and helps analyze the localization results after running `MagnetLoc.m`.

## Datasets

The `data/` directory contains six recorded trajectories:

| Dataset | Description | Initial pose |
|---|---|---|
| `circles.txt` | Several circular trajectories; odometry drift is visible over time. | `(0, 0, 0)` |
| `diagonal45degrees.txt` | Straight diagonal trajectory. | `(0, 0, pi/4)` |
| `line1magnet.txt` | Motion along the `y = 0` line, passing over one row of magnets. | `(0, 0, 0)` |
| `line2magnets.txt` | Motion along the `y = 27` line, with two rows of magnets nearby. | `(0, 27, 0)` |
| `oneloop.txt` | One-loop trajectory returning approximately to the origin. | `(0, 0, 0)` |
| `twoloops.txt` | Longer two-loop trajectory returning approximately to the origin. | `(0, 0, 0)` |

The loop datasets are particularly useful for tuning and validating the filter because the robot's final position is approximately known.

## Running the Project

1. Extract the project folder, keeping the `data/` directory inside it.
2. Open MATLAB and set the current working directory to the project root (`StudentDocs_lab_1/`).
3. Ensure that the motion-model function is available under the name expected by `MagnetLoc.m` (`EvolutionModel`).
4. Review `DefineVariances.m` and set the parameters required for the experiment.
5. To inspect the raw odometry data, run:

   ```matlab
   clear all;
   close all;
   PlotRawData;
   ```

6. To run the EKF and display its results, run:

   ```matlab
   clear all;
   close all;
   MagnetLoc;
   PlotResults;
   ```

   `MagnetLoc` prompts you to select a dataset from the `data/` directory.

## Parameter Analysis

The lab focuses on understanding and tuning:

- Initial pose uncertainty (`Pinit`).
- Magnetic measurement-noise covariance (`Qgamma`).
- Odometry/input-noise tuning (`sigmaTuning`, used to construct `Qbeta`).
- Mahalanobis-distance acceptance threshold (`mahaThreshold`).

The assignment also investigates the effects of overestimating and underestimating these parameters, the evolution of the covariance during prediction and correction, and the behavior of the EKF on all provided trajectories.

When estimating measurement noise, the lab instructions recommend temporarily setting `dumbFactor` and `subSamplingFactor` to `1`. For EKF tuning and tests, restore their standard values (`8` and `4`, respectively).

## Notes

- Run the scripts from the project root so MATLAB can find the `data/` folder.
- The scripts use global variables and workspace state; clear the workspace between independent runs.
- Do not modify unrelated parameters in `RobotAndSensorDefinition.m` unless explicitly required by the lab.
- The PDF files included in the project contain the lab assignment, setup instructions and theoretical explanations.
