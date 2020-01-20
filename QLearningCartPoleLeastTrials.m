%**************************************************************************
% Q Learning applied to Cart-Pole balancing problem.
% The environment of the learning system is a black box, from which it has
% several lines and a reinforcement line. Its task is to learn to give
% responses which maximize the scalar signals on its reinforcement line.
% The Q-value update is the following, if the system takes action a from     
%   state s at time t, and arrives at state ss with feedback r at time t+1:  
%                                                                              
%   Q(t+1, s, a) = Q(t, s, a)                                                  
%                  + alpha (r + gamma max_{b}Q(t,ss, b) - Q(t, s, a)) 


% get_box:  Given the current state, returns a number from 1 to 162
%           designating the region of the state space encompassing the current 
%           state.
%           Returns a value of -1 if a failure state is encountered.

% cart_pole: The cart and pole dynamics; given the Force and
%            current state, estimates next state

%Code written by: Nikhil Podila , Savinay Nagendra
%email id:        nikhilpodila.94@gmail.com , nagsavi17@gmail.com 
%**************************************************************************
clc;
clear all;
close all;
% Initialization

NUM_BOXES = 163;         % Number of states
ALPHA = 0.4;             % Learning rate parameter
GAMMA = 0.999;           % Discount factor for future reinforcements
Q = zeros(NUM_BOXES,2);  % State-Action Values
action = [30 -30];       % Action space (Force on cart)
MAX_FAILURES = 1000;     % Maximum number of Failures allowed
MAX_STEPS = 150000;      % Maximum number of steps (time) until Task success
epsilon = 0;             % Epsilon value for epsilon-greedy strategy of action selection

% Initializing required parameters
steps = 0;
failures = 0;
thetaPlot = 0;
xPlot = 0;

%Pendulum state initialization
theta = 0;
thetaDot = 0;
x = 0;
xDot = 0;

% Get the index of the first state (Tabular method)
box = getBox4(theta,thetaDot,x,xDot);

while(steps<=MAX_STEPS && failures<+MAX_FAILURES)

    steps = steps + 1;
    
    % Epsilon Greedy method to select the first action
    if(rand > epsilon)       % exploit
        % Select best action based on State-Action value
        [~,actionMax] = max(Q(box,:));
        currentAction = action(actionMax);
    else                   % explore
        % Select a random action
        currentAction = datasample(action,1);
    end
    
    actionIndex = find(action == currentAction); % index of chosen action
    
    % Simulate Cart-pole (Environment) dynamics
    [thetaNext,thetaDotNext,thetaacc,xNext,xDotNext] = cart_pole2(currentAction,theta,thetaDot,x,xDot);
    
    % Store environment output
    thetaPlot(end + 1) = thetaNext;
    xPlot(end + 1) = xNext;
    
    % Get index of next state
    newBox = getBox4(thetaNext,thetaDotNext,xNext,xDotNext);
    
    % Move to next state
    theta = thetaNext;
    thetaDot = thetaDotNext;
    x = xNext;
    xDot = xDotNext;
    
    % New state is below acceptable threshold.
    % Task Failed. Cart-pole is reset.
    if(newBox==163)
        
        % Negative reinforcement for failing task.
        r = -1;
        
        % Set Q value at state below threshold to 0
        Q(newBox,:) = 0;
        
        % Plot pole angle and cart distance over this trial
        figure(2);
        plot((1:length(thetaPlot)),thetaPlot,'-ob');
        figure(3);
        plot((1:length(xPlot)),xPlot,'-og');

        % Reset Cart-pole system.
        thetaPlot = 0;
        xPlot = 0;
        %Swing Up. Find the box.
        theta = 0;
        thetaDot = 0;
        x = 0;
        xDot = 0;
        
        % Get state index for reset state
        newBox = getBox4(theta,thetaDot,x,xDot);
        
        % Increment number of failures
        failures = failures + 1;
        
        % Mark number of steps in this trial until failure on plot
        fprintf('Trial %d was %d steps. \n',failures,steps);
        figure(1);
        plot(failures,steps,'-or');
        hold on;
        steps = 0;
    else
        % Reinforcement is 0
        r = 0;
    end
    
    % Q-Learning update for State-action value function
    Q(box,actionIndex) = Q(box,actionIndex) + ALPHA*(r + GAMMA*max(Q(newBox,:)) - Q(box,actionIndex));
    
    % Next state updates
    box = newBox;
end

if(failures == MAX_FAILURES)
    fprintf('Pole not balanced. Stopping after %d failures.',failures);
else
    fprintf('Pole balanced successfully for at least %d steps\n', steps);
    
    % Failures vs number of steps plot
    figure(1);
    plot(failures+1,steps,'-or');
    title("Number of steps taken to reach each Failure")
    hold on;
    
    % Pole angle and Cart position plots for best trial
    figure(2);
    plot((1:length(thetaPlot)),thetaPlot,'-ob');
    title("Pole Angle plot for the best trial")
    figure(3);
    plot((1:length(xPlot)),xPlot,'-og');
    title("Cart Position plot for the best trial")
    
    % Sample plots for pole angle and cart position for best trial (Few steps)
    figure(4);
    plot((1:301),thetaPlot(1:301),'-ob');
    title("Pole Angle plot (few samples) for the best trial")
    hold on;
    figure(5);
    plot((1:301),xPlot(1:301),'-og');
    title("Cart Position plot (few samples) for the best trial")
    hold on;
end
