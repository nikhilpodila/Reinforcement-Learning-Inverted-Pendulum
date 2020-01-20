# Reinforcement-Learning-Inverted-Pendulum

Authors: Nikhil Podila, Savinay Nagendra

This project was carried out by the authors in their Final semester of Undergraduation (Bachelor of Engineeering) under the guidance of Professor Koshy George at the Center of Intelligent Systems in PES Institute of Technology, Bangalore, India.

## Usage
1. The code must be opened in MATLAB R2017a and above.
2. **Tabular Reinforcement Learning solutions**:
    1. **CartPoleLearningSystem.m**: Temporal Difference Learning (SARSA) algorithm as explained in Sutton's Dissertation has been implemented on the Inverted Pendulum problem.
    2. **QLearningCartPole.m**: Standard Q-Learning algorithm
    3. **QLearningCartPoleLeastTrials.m**: Q-Learning algorithm, optimized hyperparameters
    4. **QLearningCartPoleThetaCheck.m**: Q-Learning algorithm, with focus on pendulum angle
    5. **SarsaLearningCartPole.m**: Standard SARSA algorithm
    6. **SarsaLearningCartPoleLeastTrials.m**: SARSA algorithm, optimized hyperparameters
    7. **SarsaLearningCartPoleThetaCheck.m**: SARSA algorithm, with focus on pendulum angle
3. **Reinforcement Learning with Function approximation**:
    1. **linfun1.m**: SARSA algorithm with Linear Function Approximation
4. **Solutions integrated with Swing-up**:
    1. **SarsaLearningCartPoleSwingUp.m**: Tabular SARSA algorithm, with Pendulum swing up using Energy Method
    2. **linfun1SwingUp.m**: SARSA algorithm with Linear Function approximation, with Pendulum swing up using Energy method
