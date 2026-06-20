`include "params.vh"

module traffic_fsm
#(
    parameter MAIN_IS_NS = 1,
    parameter TICK_HZ    = 10
)
(
    input wire clk,
    input wire rst_n,
    input wire tick,

    input wire veh_ns,
    input wire veh_ew,

    input wire ped_pulse,
    input wire emergency,
    input wire night_mode,

    output reg ns_g,
    output reg ns_y,
    output reg ns_r,

    output reg ew_g,
    output reg ew_y,
    output reg ew_r,

    output reg ped_walk,
    output reg ped_dontwalk
);
localparam S_NS_G          = 4'd0;
localparam S_NS_Y          = 4'd1;
localparam S_ALL_RED1      = 4'd2;
localparam S_EW_G          = 4'd3;
localparam S_EW_Y          = 4'd4;
localparam S_ALL_RED2      = 4'd5;
localparam S_PED_WALK      = 4'd6;
localparam S_EMERG_ALL_RED = 4'd7;
localparam S_NIGHT         = 4'd8;

reg [3:0] state;
reg [3:0] next_state;

reg ped_req;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        ped_req <= 1'b0;

    else if(ped_pulse)
        ped_req <= 1'b1;

    else if(state == S_PED_WALK)
        ped_req <= 1'b0;
end

reg start_timer;
reg [15:0] timer_ticks;

wire timer_busy;

timer u_timer
(
    .clk(clk),
    .rst_n(rst_n),
    .tick(tick),

    .start(start_timer),
    .ticks_to_run(timer_ticks),

    .busy(timer_busy)
);

function [15:0] SEC;
    input integer s;
    begin
        SEC = s * TICK_HZ;
    end
endfunction

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        state <= S_NS_G;

    else if(emergency)
        state <= S_EMERG_ALL_RED;

    else if(night_mode)
        state <= S_NIGHT;

    else
        state <= next_state;
end

always @(*)
begin

    next_state  = state;
    start_timer = 1'b0;
    timer_ticks = 16'd0;

    ns_g = 1'b0;
    ns_y = 1'b0;
    ns_r = 1'b0;

    ew_g = 1'b0;
    ew_y = 1'b0;
    ew_r = 1'b0;

    ped_walk     = 1'b0;
    ped_dontwalk = 1'b1;

    case(state)

        S_NS_G:
        begin
            ns_g = 1'b1;
            ew_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_GREEN_MIN_S);

                if(ped_req || veh_ew)
                    next_state = S_NS_Y;
            end
        end

        S_NS_Y:
        begin
            ns_y = 1'b1;
            ew_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_YELLOW_S);

                next_state = S_ALL_RED1;
            end
        end

        S_ALL_RED1:
        begin
            ns_r = 1'b1;
            ew_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_ALLRED_S);

                if(ped_req)
                    next_state = S_PED_WALK;
                else
                    next_state = S_EW_G;
            end
        end

            S_EW_G:
        begin
            ew_g = 1'b1;
            ns_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_GREEN_MIN_S);

                if(ped_req || veh_ns)
                    next_state = S_EW_Y;
            end
        end

        S_EW_Y:
        begin
            ew_y = 1'b1;
            ns_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_YELLOW_S);

                next_state = S_ALL_RED2;
            end
        end

        S_ALL_RED2:
        begin
            ns_r = 1'b1;
            ew_r = 1'b1;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_ALLRED_S);

                if(ped_req)
                    next_state = S_PED_WALK;
                else
                    next_state = S_NS_G;
            end
        end

        S_PED_WALK:
        begin
            ns_r = 1'b1;
            ew_r = 1'b1;

            ped_walk     = 1'b1;
            ped_dontwalk = 1'b0;

            if(!timer_busy)
            begin
                start_timer = 1'b1;
                timer_ticks = SEC(`T_WALK_S);

                next_state = S_NS_G;
            end
        end

        S_EMERG_ALL_RED:
        begin
            ns_r = 1'b1;
            ew_r = 1'b1;

            if(!emergency)
                next_state = S_NS_G;
        end

        S_NIGHT:
        begin
            ped_dontwalk = 1'b1;

            if(MAIN_IS_NS)
            begin
                ns_y = tick;
                ew_r = tick;
            end
            else
            begin
                ew_y = tick;
                ns_r = tick;
            end

            if(!night_mode)
                next_state = S_NS_G;
        end

        default:
        begin
            next_state = S_NS_G;
        end

    endcase
end

endmodule