module signed_divider(
    input wire [31:0] dividend,
    input wire [31:0] divisor,
    output reg [31:0] quotient,
    output reg [31:0] remainder
);

// Internal variables
reg [31:0] temp_dividend, temp_divisor;
reg dividend_sign, divisor_sign;
integer i;

// Division process with sign handling
always @(dividend or divisor) begin
    // Determine the signs of dividend and divisor
    dividend_sign = dividend[31];
    divisor_sign = divisor[31];
    
    // Convert dividend and divisor to positive if they are negative
    temp_dividend = dividend_sign ? -dividend : dividend;
    temp_divisor = divisor_sign ? -divisor : divisor;

    // Initial assignments
    quotient = 0;
    remainder = 0;

    // Check for divide by zero
    if (temp_divisor == 0) begin
        quotient = 32'hFFFFFFFF; // Indicate error or overflow
        remainder = temp_dividend;    // Remainder is unchanged
    end
    else begin
        for (i = 31; i >= 0; i = i - 1) begin
            // Shift remainder left, bring in next bit from dividend
            remainder = remainder << 1;
            remainder[0] = temp_dividend[i];
            
            // Subtract divisor from remainder, if remainder >= divisor
            if (remainder >= temp_divisor) begin
                remainder = remainder - temp_divisor;
                quotient[i] = 1'b1; // Set quotient bit
            end
        end
        
        // Adjust the sign of the quotient
        if (dividend_sign ^ divisor_sign) begin
            quotient = -quotient;
        end
        
        // Adjust the sign of the remainder to match the dividend's original sign
        if (dividend_sign) begin
            remainder = -remainder;
        end
    end
end

endmodule