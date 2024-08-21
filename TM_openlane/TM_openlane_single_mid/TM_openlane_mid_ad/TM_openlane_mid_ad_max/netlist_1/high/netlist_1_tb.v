`timescale 1ns / 1ps 
 
module netlist_1_tb;
 
//INPUTS
reg \clk ;
reg \in0 ;
reg \in1 ;
reg \in10 ;
reg \in11 ;
reg \in12 ;
reg \in13 ;
reg \in14 ;
reg \in15 ;
reg \in16 ;
reg \in17 ;
reg \in18 ;
reg \in19 ;
reg \in2 ;
reg \in20 ;
reg \in21 ;
reg \in22 ;
reg \in23 ;
reg \in24 ;
reg \in25 ;
reg \in26 ;
reg \in27 ;
reg \in28 ;
reg \in29 ;
reg \in3 ;
reg \in30 ;
reg \in31 ;
reg \in32 ;
reg \in33 ;
reg \in34 ;
reg \in35 ;
reg \in36 ;
reg \in37 ;
reg \in38 ;
reg \in39 ;
reg \in4 ;
reg \in40 ;
reg \in41 ;
reg \in42 ;
reg \in43 ;
reg \in44 ;
reg \in45 ;
reg \in46 ;
reg \in47 ;
reg \in48 ;
reg \in49 ;
reg \in5 ;
reg \in50 ;
reg \in51 ;
reg \in52 ;
reg \in53 ;
reg \in54 ;
reg \in55 ;
reg \in56 ;
reg \in57 ;
reg \in58 ;
reg \in59 ;
reg \in6 ;
reg \in60 ;
reg \in61 ;
reg \in7 ;
reg \in8 ;
reg \in9 ;
reg \rst ;

//OUTPUTS
wire \out0 ;
wire \out1 ;
wire \out10 ;
wire \out11 ;
wire \out12 ;
wire \out13 ;
wire \out14 ;
wire \out15 ;
wire \out16 ;
wire \out17 ;
wire \out18 ;
wire \out19 ;
wire \out2 ;
wire \out20 ;
wire \out21 ;
wire \out22 ;
wire \out23 ;
wire \out24 ;
wire \out25 ;
wire \out26 ;
wire \out27 ;
wire \out28 ;
wire \out29 ;
wire \out3 ;
wire \out30 ;
wire \out31 ;
wire \out32 ;
wire \out33 ;
wire \out34 ;
wire \out35 ;
wire \out36 ;
wire \out37 ;
wire \out38 ;
wire \out39 ;
wire \out4 ;
wire \out40 ;
wire \out41 ;
wire \out42 ;
wire \out43 ;
wire \out44 ;
wire \out45 ;
wire \out46 ;
wire \out47 ;
wire \out48 ;
wire \out49 ;
wire \out5 ;
wire \out50 ;
wire \out51 ;
wire \out52 ;
wire \out53 ;
wire \out54 ;
wire \out55 ;
wire \out56 ;
wire \out57 ;
wire \out58 ;
wire \out59 ;
wire \out6 ;
wire \out60 ;
wire \out61 ;
wire \out7 ;
wire \out8 ;
wire \out9 ;

// Instantiate the Unit Under Test (UUT)
netlist_1 uut (.\clk (\clk ), .\in0 (\in0 ), .\in1 (\in1 ), .\in10 (\in10 ), .\in11 (\in11 ), .\in12 (\in12 ), .\in13 (\in13 ), .\in14 (\in14 ), .\in15 (\in15 ), .\in16 (\in16 ), .\in17 (\in17 ), .\in18 (\in18 ), .\in19 (\in19 ), .\in2 (\in2 ), .\in20 (\in20 ), .\in21 (\in21 ), .\in22 (\in22 ), .\in23 (\in23 ), .\in24 (\in24 ), .\in25 (\in25 ), .\in26 (\in26 ), .\in27 (\in27 ), .\in28 (\in28 ), .\in29 (\in29 ), .\in3 (\in3 ), .\in30 (\in30 ), .\in31 (\in31 ), .\in32 (\in32 ), .\in33 (\in33 ), .\in34 (\in34 ), .\in35 (\in35 ), .\in36 (\in36 ), .\in37 (\in37 ), .\in38 (\in38 ), .\in39 (\in39 ), .\in4 (\in4 ), .\in40 (\in40 ), .\in41 (\in41 ), .\in42 (\in42 ), .\in43 (\in43 ), .\in44 (\in44 ), .\in45 (\in45 ), .\in46 (\in46 ), .\in47 (\in47 ), .\in48 (\in48 ), .\in49 (\in49 ), .\in5 (\in5 ), .\in50 (\in50 ), .\in51 (\in51 ), .\in52 (\in52 ), .\in53 (\in53 ), .\in54 (\in54 ), .\in55 (\in55 ), .\in56 (\in56 ), .\in57 (\in57 ), .\in58 (\in58 ), .\in59 (\in59 ), .\in6 (\in6 ), .\in60 (\in60 ), .\in61 (\in61 ), .\in7 (\in7 ), .\in8 (\in8 ), .\in9 (\in9 ), .\rst (\rst ), .\out0 (\out0 ), .\out1 (\out1 ), .\out10 (\out10 ), .\out11 (\out11 ), .\out12 (\out12 ), .\out13 (\out13 ), .\out14 (\out14 ), .\out15 (\out15 ), .\out16 (\out16 ), .\out17 (\out17 ), .\out18 (\out18 ), .\out19 (\out19 ), .\out2 (\out2 ), .\out20 (\out20 ), .\out21 (\out21 ), .\out22 (\out22 ), .\out23 (\out23 ), .\out24 (\out24 ), .\out25 (\out25 ), .\out26 (\out26 ), .\out27 (\out27 ), .\out28 (\out28 ), .\out29 (\out29 ), .\out3 (\out3 ), .\out30 (\out30 ), .\out31 (\out31 ), .\out32 (\out32 ), .\out33 (\out33 ), .\out34 (\out34 ), .\out35 (\out35 ), .\out36 (\out36 ), .\out37 (\out37 ), .\out38 (\out38 ), .\out39 (\out39 ), .\out4 (\out4 ), .\out40 (\out40 ), .\out41 (\out41 ), .\out42 (\out42 ), .\out43 (\out43 ), .\out44 (\out44 ), .\out45 (\out45 ), .\out46 (\out46 ), .\out47 (\out47 ), .\out48 (\out48 ), .\out49 (\out49 ), .\out5 (\out5 ), .\out50 (\out50 ), .\out51 (\out51 ), .\out52 (\out52 ), .\out53 (\out53 ), .\out54 (\out54 ), .\out55 (\out55 ), .\out56 (\out56 ), .\out57 (\out57 ), .\out58 (\out58 ), .\out59 (\out59 ), .\out6 (\out6 ), .\out60 (\out60 ), .\out61 (\out61 ), .\out7 (\out7 ), .\out8 (\out8 ), .\out9  (\out9 ));
 
reg clk;
 integer i = 0;
reg[63:0] in_vector [0:999];
parameter test_data = "/nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/high/netlist_1_input_vector.txt";
 
initial begin
 $readmemb(test_data, in_vector);
 end 
 
always
 begin
 clk=1'b1;
 #1001;
 clk=1'b0;
 #1001;
 end 
 
always @(posedge clk)
 begin
if (i<1000) begin
{\clk , \in0 , \in1 , \in10 , \in11 , \in12 , \in13 , \in14 , \in15 , \in16 , \in17 , \in18 , \in19 , \in2 , \in20 , \in21 , \in22 , \in23 , \in24 , \in25 , \in26 , \in27 , \in28 , \in29 , \in3 , \in30 , \in31 , \in32 , \in33 , \in34 , \in35 , \in36 , \in37 , \in38 , \in39 , \in4 , \in40 , \in41 , \in42 , \in43 , \in44 , \in45 , \in46 , \in47 , \in48 , \in49 , \in5 , \in50 , \in51 , \in52 , \in53 , \in54 , \in55 , \in56 , \in57 , \in58 , \in59 , \in6 , \in60 , \in61 , \in7 , \in8 , \in9 , \rst }=in_vector[i];
i=i+1;
 end
end
 
endmodule