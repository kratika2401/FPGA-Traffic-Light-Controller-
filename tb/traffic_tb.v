`timescale 1ns/1ps

module traffic_tb;

reg clk = 0;
reg rst_btn = 1;

reg veh_ns = 0;
reg veh_ew = 0;

reg ped = 0;
reg emer = 0;
reg night = 0;

wire NS_G;
wire NS_Y;
wire NS_R;

wire EW_G;
wire EW_Y;
wire EW_R;

wire PW;
wire PD;

top DUT
(
    .clk_50m(clk),
    .rst_btn(rst_btn),

    .veh_ns_raw(veh_ns),
    .veh_ew_raw(veh_ew),

    .ped_btn_raw(ped),
    .emergency_raw(emer),
    .night_raw(night),

    .NS_G(NS_G),
    .NS_Y(NS_Y),
    .NS_R(NS_R),

    .EW_G(EW_G),
    .EW_Y(EW_Y),
    .EW_R(EW_R),

    .PED_WALK(PW),
    .PED_DONT(PD)
);

always #5 clk = ~clk;

always @(posedge clk)
begin
    if(NS_G && EW_G)
    begin
        $display("ERROR : Both directions GREEN!");
        $finish;
    end
end

initial
begin

    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_tb);

    #100;
    rst_btn = 0;

    // EW vehicle request
    #20000;
    veh_ew = 1;

    #10000;
    veh_ew = 0;

    // pedestrian request
    #15000;
    ped = 1;

    #20000;
    ped = 0;

    // emergency
    #20000;
    emer = 1;

    #20000;
    emer = 0;

    // night mode
    #40000;
    night = 1;

    #40000;
    night = 0;

    #200000;
    $finish;

end

endmodule