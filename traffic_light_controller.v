module traffic_light_6state(
input clk, rst,
output reg [2:0] ns, // {R,Y,G}
output reg [2:0] ew // {R,Y,G}
);
reg [2:0] state, next_state;
reg [4:0] count; // counter
// State encoding
parameter S0=3'd0, S1=3'd1, S2=3'd2,
S3=3'd3, S4=3'd4, S5=3'd5;
// Sequential block
always @(posedge clk or posedge rst) begin
if (rst) begin
state <= S0;
count <= 0;
end else begin
if ((state==S0 && count==15) ||
(state==S1 && count==3) ||
(state==S2 && count==3) ||
(state==S3 && count==15) ||
(state==S4 && count==3) ||
(state==S5 && count==3)) begin
state <= next_state;
count <= 0;
end else begin
count <= count + 1;
end
end
end
// Next state logic
always @(*) begin
case(state)
S0: next_state = S1;
S1: next_state = S2;
S2: next_state = S3;
S3: next_state = S4;
S4: next_state = S5;
S5: next_state = S0;
default: next_state = S0;
endcase
end
// Output logic
always @(*) begin
case(state)
S0: begin ns=3'b001; ew=3'b100; end // NS G, EW R
S1: begin ns=3'b010; ew=3'b100; end // NS Y, EW R
S2: begin ns=3'b100; ew=3'b100; end // All R
S3: begin ns=3'b100; ew=3'b001; end // NS R, EW G
S4: begin ns=3'b100; ew=3'b010; end // NS R, EW Y
S5: begin ns=3'b100; ew=3'b100; end // All R
default: begin ns=3'b100; ew=3'b100; end
endcase
end
endmodule
