module tb_traffic_light_6state;
reg clk, rst;
wire [2:0] ns, ew; // {R,Y,G}
traffic_light_6state dut (
.clk(clk),
.rst(rst),
.ns(ns),
.ew(ew)
);
// Clock generator (10ns period = 100 MHz)
initial clk = 0;
always #5 clk = ~clk;
// Stimulus
initial begin
// Apply reset
rst = 1;
#20 rst = 0;
#2000 $finish;
end
initial begin
$display("Time\t NS \t EW");
$monitor("%0t\t %b \t %b", $time, ns, ew);
end
endmodule
