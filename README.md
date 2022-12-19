# MEKF
Multiplicative Extended Kalman Filter.

This is the Simulink Implementation used in the publication of the paper 
"**A Comparative Analysis Between the Additive and the Multiplicative Extended Kalman Filter for Satellite Attitude Determination**"

The abstract can be read below. 

To run the code: 
1. Install the newest version of Matlab.
2. Install the Robotics ToolBox. 
3. Run the initializer (SystemVariables.m) to get the variables into the Simulink Workspace.
4. Run.


Abstract: 

"*The general consensus is that the Multiplicative Extended Kalman Filter (MEKF) is superior to the Additive Extended Kalman Filter (AEKF) based on a wealth of theoretical evidence. This paper deals with a practical comparison between the two flters in simulation with the goal of verifying if the previous theoretical foundations are true. The AEKF and MEKF are two variants of the Extended Kalman Filter that differ in their approach to linearizing the system dynamics. The AEKF uses an additive correction term to update the state estimate, while the MEKF uses a multiplicative correction term. The two also differ in the state of which they use. The AEKF uses the quaternion as its state while the MEKF uses the Gibbs vector as its state. The results show that the MEKF consistently outperforms the AEKF in terms of estimation accuracy with lower uncertainty. The AEKF is more computationally effcient, but the difference is so low that it is almost negligible and it has no effect on a realtime application. Overall, the results suggest that the MEKF is a better choise for satellite attitude estimation due to its superior estimation accuracy and lower uncertainty, which agrees with the statements from previous work*"


