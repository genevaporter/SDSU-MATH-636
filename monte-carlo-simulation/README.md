# MonteCarlo
Hospital expansion Simulation

Consider the classic hospital expansion problem put forth by Schmitz and Kwak in 
their 1971 paper "Monte Carlo Simulation of Operating-Room and Recovery-Room Usage." 
In this paper, they outline a simulation based on the number of operating rooms 
and recovery rooms planned for a new hospital wing ICU, with the goal of answering 
the following questions:

(1)  How many more surgeries are performed because of the increased bed capacity?

(2)  How much operating room time and space will the surgeries require?

(3)  How much recovery room time and space will the surgeries require?

We will use Schmitz and Kwak's results for the first question to answer the second 
and third questions. They were able to gather enough data to create a rubric for the 
percentage of increased surgeries as well as the likelihood of any particular surgery 
that is needed. Their simulation was structured using the following criteria: Incoming 
patients will each need surgery, and the type of surgery is simulated using a 
probability distribution. Operating rooms open at 7.5 hours (0700), and the length of 
each surgery varies between 0.5 and 4 hours. Once a patient is out of surgery, the 
operating room takes 0.25 hours to clean and prep for the next patient. Patients that 
use a recovery bed will take 0.08 hours to travel from the operation room to the recovery 
room, and stay there for the appropriate length of time depending on their surgical 
procedure. Once a patient leaves the recovery room, it takes 0.25 hours to prepare the bed 
for the next patient. Beds are filled ordinally as they become available. If there are no 
beds available when a patient leaves surgery, a new bed will be opened.
