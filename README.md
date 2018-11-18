# 5 Stage Pipelined Datapath
**Work in Progress**

This was my final project for Advanced Computer Organization. We were given a set of 16-bit pseudo-MIPS instructions and were asked to design a pipelined datapath that would be able to execute all of the instructions. The project handout with detailed information about the instructions can be found at:

## First Stage
The first stage of this project was the design of the datapath. We had to determine what kind of hardware was required to exacute all the instructions and draw out the connections between each component. We used MS Visio to draw connections and create a diagram. This kan be found here: 

## Second Stage
The second stage was to code each individual component using Verilog and instantiate them into a top module called CPU.v. We then wrote a testbench file, CPU_test_fixture.v, to debug our datapath. This is where I did most of the wark, but I did most of it in my spare time as I found it interesting and a bit of fun.

## Mishaps
we ran into many of our issues during the debug stage. This is what kept us from getting 100% on the project. While we got a few of the instructions working, the entire program did not run correctly. This was because we did not allot enough time for the debugging stage and weren't able to correct all the errors.

## Group Contributions
This was assigned to us in groups of two. I ended up coding each individual component module as well as most of the CPU and CPU_test_fixture file. I did most of the coding for fun during my free time as I found it really interesting writing code to simulate hardware and write testbenches for each component to show they worked. My partner helped with the debuging and wrote the report.

## Future plans
As stated, this is a work in progress as I want to get the entire program working with all 40 of the given instructions. I am pretty busy with my current class load and track, but I plan on finishing before I graduate.
