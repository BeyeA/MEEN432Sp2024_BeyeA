Instructions: Download the P3_Model_Final_V2.slx, P3_RunSim_Final.m, Finalinit.m, init_HWY_DriveCycle.m, and init_URB_DriveCycle.m files and place them within the same directory. Open the P3_Model_Final_V2.slx Simulink file. Then, open the P3_RunSim_Final.m file and click "Run" to run the script. The expected output is two figures, one for the highway drive cycle and the other for the urban drive cycle. The simulated velocity should be within the 3mph error and at all times.

For the final week of Project 3, an electric motor drive and battery subsystems were added into an electric motor drive block, replacing the simplified powertrain model.

The electric motor subsystem takes battery voltage, throttle % command, and motor speed as inputs. Then, it interpolates a max torque curve used for max torque values using the motorData.maxtorque, motorData.vbus, and motorData.rpm tables provided in the Finalinit.m file. The motor efficiency curve is found similarly, using interpolation based on the motorData.eta_torque and  motorData.eta_speed values provided. The block then calculates Current, Motor Torque, and Motor Inertia as outputs. 

The battery subsystem then takes Current as an input. It then finds the current in the cells by dividing the input current by the number of cells in parallel. The SOC is then calculated and the OCV is found through interpolation using the batData.OCV and batData.SOC values from Finalinit. The voltage is then calculated by multiplying the number of cells in series by the product of OCV minus the product of internal resistance per cell and the current of each cell. Finally, the subsystem outputs the Battery Voltage (V) and SOC. 

Per the Project 3 deliverables, the model follows the 2 EPA drive cycles within the +- 3 mph error band. It uses driver, braking, electric motor, battery, transmission, wheel, and longitudinal dynamic systems to produce two figures displaying the Urban and Highway drive cycles. The battery's and motor's energy and power can be observed for each drive cycle in the simout_hwy and simout_urb simulation output variables respectively. 

 ## Final Submission Feedback (85/85)
In this feedback I will be going through each of the main components of the Simulink model and provide any corrections that should be made.
1) Drive Schedule: No comment
2) Driver Model: No comment
3) Battery: The only thing I want to mention for the battery is the conversion of the total battery capacity. The team did 1 thing correctly by dividing by the number of cells in parallel to get the capacity per cell, but are missing the conversion from Amp-hr to Amp-s, so make sure to add 3600 to the gain.
4) Electric Motor: No comment
5) Transmission: No comment
6) Wheel Model: No comment
7) Vehicle Model: No comment
8) Brake Model: There are a few things missing from the brake logic that I want to mention real quick. The brake has two states Locked and Unlocked and we want to try to replicate that here in the brake logic
- The brake is considered to be in the Locked state when the brake%cmd == 0, so Tb = -Tw (or Tw, depends on the sign of brake%cmd)
- The brake is considered to be in the Unlocked state when brake%cmd does not == 0, so Tb = - brake%cmd * Nb,max * (Ww/(abs(Ww) + 0.001)), where Nbmax is the calibratable gain value 10000, and Ww is the angular velocity of the wheel (might be positive, again depends on sign of brake%cmd)

The vehicle ran well despite these changes but I would suggest making the changes mentioned for Project 4.
