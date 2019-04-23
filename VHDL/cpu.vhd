----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2017 16:21:29
-- Design Name: 
-- Module Name: cpu - Structual
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity cpu is
	port (
	clk100Mhz : in std_logic;
	reset : in std_logic;
	led : out std_logic_vector (16 - 1 downto 0);
	--jump : out std_logic_vector (14 - 1 downto 0);
	switch : in std_logic_vector (21 - 1 downto 0);
	hsync : out std_logic;
	vsync : out std_logic;
	rgb : out std_logic_vector (12 - 1 downto 0)
	--clk2out: out std_logic;
	--clk1out: out std_logic

	);
end cpu;

architecture Structual of cpu is
	signal func3 : std_logic_vector(2 downto 0);
	signal func7 : std_logic_vector(6 downto 0);
	signal sel_bit : std_logic;
	signal reg1 : std_logic_vector(4 downto 0);
	signal reg2 : std_logic_vector(4 downto 0);
	signal regout : std_logic_vector(4 downto 0);
	signal data1 : std_logic_vector(31 downto 0);
	signal data2 : std_logic_vector(31 downto 0);
	signal dataout : std_logic_vector(31 downto 0);
    signal write_enable : std_logic;
    signal selector_reg : std_logic_vector (2 - 1 downto 0);
    signal selector_bra : std_logic_vector (2 - 1 downto 0);
	signal imm_select : std_logic;
	signal imm_data : std_logic_vector(31 downto 0);
	signal reg_data : std_logic_vector(31 downto 0);
	signal write_enable_ram : std_logic;
	signal wdata_ram : std_logic_vector (32 - 1 downto 0);
	signal radr_ram : std_logic_vector (14 - 1 downto 0);
	signal padr_ram : std_logic_vector (14 - 1 downto 0);
	signal rdata_ram : std_logic_vector (32 -1 downto 0);
	signal pdata_ram : std_logic_vector (32 -1 downto 0);
	signal write_enable_pc : std_logic;
	signal set_adress : std_logic;
	signal wadr_pc : std_logic_vector (16 - 1 downto 0);
	signal radr_pc : std_logic_vector (16 - 1 downto 0);
	signal instruction : std_logic_vector (32 - 1 downto 0);
	signal ram_offset : std_logic_vector (12 - 1 downto 0);
	signal ram_width : std_logic_vector (3 - 1 downto 0);
	signal write_enable_ram_io : std_logic;
	signal write_enable_io : std_logic;
	signal adr_io : std_logic;
	signal wdata_io : std_logic_vector (16 - 1 downto 0);
	signal rdata_io : std_logic_vector (21 - 1 downto 0);
	signal alu_register : std_logic_vector (32 - 1 downto 0);
	signal ram_register : std_logic_vector (32 - 1 downto 0);
	signal write_io : std_logic;
	signal data_io_0 : std_logic_vector (16 - 1 downto 0);
	signal data_io_1 : std_logic_vector (21 - 1 downto 0);
	signal reset_inv : std_logic;
	signal from_id : std_logic_vector (32 - 1 downto 0);
	signal from_bp : std_logic_vector (32 - 1 downto 0);
	signal clk1 : std_logic;
	signal clk2 : std_logic;
	signal lock : std_logic;
	signal reset_l : std_logic;
    signal data : std_logic_vector (32 - 1 downto 0);
    signal to_display_data : std_logic_vector (32 - 1 downto 0);
    signal change_state : std_logic;
    signal stop_cpu : std_logic;
    signal mk_nop : std_logic;
    signal write_ram : std_logic_vector (1 - 1 downto 0);
	

	component alu is
    Port ( data1 : in STD_LOGIC_VECTOR(31 downto 0);
           data2 : in STD_LOGIC_VECTOR(31 downto 0);
           func3 : in STD_LOGIC_VECTOR(2 downto 0);
           selector_bit : in STD_LOGIC;
           is_imm : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(31 downto 0));
	end component alu;

	component alu_in_mult
	Port (
		reg_in : in std_logic_vector(32-1 downto 0);
		imm_in : in std_logic_vector(32-1 downto 0);
		selector : in std_logic;
		data_out : out std_logic_vector(32-1 downto 0)
	); 
	end component;

	component instruction_decoder is
	Port (
        instruction : in std_logic_vector (32 - 1  downto 0); --Instruction
        rs1 : out std_logic_vector (5 - 1 downto 0); --Adress first register
        rs2 : out std_logic_vector (5 - 1 downto 0); -- Adress second register
        rd : out std_logic_vector (5 - 1 downto 0); -- Adress write register
        funct3 : out std_logic_vector (3 - 1 downto 0); --ALU set first
        funct7 : out std_logic_vector (7 - 1 downto 0); --ALU set second
        rwrite : out std_logic; --Set Write Bit
        selector : out std_logic_vector (2 - 1 downto 0); --activate Alu
        selector_bra : out std_logic_vector (2 - 1 downto 0); --activate Brancher
        imm_select : out std_logic;
        imm_out : out std_logic_vector (32-1 downto 0);
        ram_offset : out std_logic_vector (12 -1 downto 0);
        ram_width : out std_logic_vector (3 - 1 downto 0);
        ram_r_w : out std_logic;
        pc_r_w: out std_logic;
        to_register: out std_logic_vector (32 - 1 downto 0);
        halt_cpu :out std_logic;
        clk : in std_logic;
        stop_cpu :in std_logic
        );
    end component instruction_decoder;

	component registerfile is 
	generic(wordSize : integer := 32; -- number of bits in a register
                adrSize  : integer := 5); -- number of address bits
    port(clk : in std_logic;
         writeEnable : in std_logic;
         wAdr  : in std_logic_vector(adrSize  - 1 downto 0);
         wData : in std_logic_vector(wordSize - 1 downto 0);
         rAdr_1 : in std_logic_vector(adrSize - 1 downto 0);
         rAdr_2 : in std_logic_vector(adrSize - 1 downto 0);
         rData_1 : out std_logic_vector(wordSize - 1 downto 0);
         rData_2 : out std_logic_vector(wordSize - 1 downto 0));

	end component registerfile;
	
    component ram2 is
    port (  clk : in std_logic;
               adrA : in std_logic_vector (14 - 1 downto 0);
               dOutA : out std_logic_vector (32 - 1 downto 0);
               
               writeEnableB : in std_logic;
               adrB : in std_logic_vector (14 - 1 downto 0);
               dInB : in std_logic_vector (32 - 1 downto 0);
               dOutB : out std_logic_vector (32 - 1 downto 0));    
    end component ram2;
    
    component blk_mem_gen_0 is
     PORT (
       clka : IN STD_LOGIC;
       wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
       addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
       dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       clkb : IN STD_LOGIC;
       web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
       addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
       dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
     );
    end component blk_mem_gen_0;
    
    component ram_io_mult is
    Port (r_w : in std_logic; -- 0 read 1 write
          r_w_ram : out std_logic; -- Write bit for RAM
          r_w_io : out std_logic; -- Write bit for IO
          offset : in std_logic_vector (12 - 1 downto 0); --Offset
          width : in std_logic_vector (3 -1 downto 0); --witch modus
          from_register_adress : in std_logic_vector (32 - 1 downto 0); --adress from Register
          from_register_data : in std_logic_vector (32 - 1 downto 0); --data from Register
          to_ram_adress : out std_logic_vector (14 - 1 downto 0); --adress Ram
          to_ram_data : out std_logic_vector (32 - 1 downto 0); --Data to ram
          from_ram_data: in std_logic_vector (32 - 1 downto 0); -- data from Ram
          to_register_data: out std_logic_vector (32 - 1 downto 0); --data to register
          to_io_adress : out std_logic; --adress IO
          to_io_data : out std_logic_vector (16 - 1 downto 0); --data to IO
          from_io_data : in std_logic_vector (21 - 1 downto 0); --data from IO
          to_display : out std_logic_vector (32 - 1 downto 0);
          to_display_data: out std_logic_vector (32 - 1 downto 0)
          );
    end component ram_io_mult;
    
    component Instruction_Fetch is
        Port (   
            inst_in_adress : in std_logic_vector (16 - 1 downto 0); --von PC
            inst_out_adress : out std_logic_vector (14 - 1 downto 0);--an Ram
            inst_in_code : in std_logic_vector (32 - 1 downto 0); --Instruction von Ram
            inst_out_code : out std_logic_vector (32 - 1 downto 0); --Instruction an ID 
            stop_cpu : in std_logic;
            mk_nop : in std_logic  
        );
    end component Instruction_Fetch;

    component programm_counter is
    Port (
        clk : in std_logic;
        inst_out_adress : out std_logic_vector (16 - 1 downto 0);
        inst_in_adress : in std_logic_vector (16 - 1 downto 0);
        set_adress : in std_logic;
        reset : in std_logic;
        stop_cpu : in std_logic
    );
    end component programm_counter;

    component io_mult is
      Port (
            io_rw : in std_logic;
            write : out std_logic;
            io_adress : in std_logic;
            io_to_data : in std_logic_vector (16 - 1 downto 0);
            io_from_data : out std_logic_vector (21 - 1 downto 0);
            data_io_0 : out std_logic_vector (16 - 1 downto 0);
            data_io_1 : in std_logic_vector (21 - 1 downto 0)
            );
    end component io_mult;
    
    component register_mult is
        Port (to_register : out std_logic_vector (32 - 1 downto 0);
              from_ram_io : in std_logic_vector (32 - 1 downto 0);
              from_alu : in std_logic_vector (32 - 1 downto 0);
              from_pc : in std_logic_vector (32 - 1 downto 0);
              from_id : in std_logic_vector (32 - 1 downto 0);
              selector : in std_logic_vector (2 - 1 downto 0)
              );
    end component register_mult;
    
    
    component debouncer_32 is
      Port (clk : in std_logic;
            data_in : in std_logic_vector (21 - 1 downto 0);
            data_out : out std_logic_vector (21 - 1 downto 0)
            );
    end component debouncer_32;

    component output is
      Port (clk : in std_logic;
            reset : in std_logic;
            write : in std_logic;
            data_in : in std_logic_vector (16 - 1 downto 0);
            data_out : out std_logic_vector (16 - 1 downto 0));
    end component output;
    
    component branch_predictor is
      Port (                                                      --B-Type       / AUIPC      / JAL          / JALR
            data1 : in std_logic_vector(32 - 1 downto 0);         --rs1          / -          / -            / rs1
            data2 : in std_logic_vector(32 - 1 downto 0);         --rs2          / -          / -            / -
            r1 : in std_logic_vector(5 - 1 downto 0);             -- -           / imm[19:15] / imm[19:15]   / -
            r2 : in std_logic_vector(5 - 1 downto 0);             -- -           / imm[24:20] / imm[4:1|11]  / imm[4:0]
            rd : in std_logic_vector(5 - 1 downto 0);             --imm[4:1|11]  / -          / -            / -
            funct7 : in std_logic_vector(7 - 1 downto 0);         --imm[12|10:5] / imm[31:25] / imm[20|10:5] / imm[11:5]
            funct3 : in std_logic_vector(3 - 1 downto 0);         --funct3       / imm[14:12] / imm[14:12]   / funct3
            pc_in : in std_logic_vector(16 - 1 downto 0);         --current PC
            write_enable_pc : in std_logic;                       --is b-type
            selector_bra : in std_logic_vector(2 - 1 downto 0);   --mult
            pc_out : out std_logic_vector(16 - 1 downto 0);       --new PC
            set_adress : out std_logic;                           --set new PC
            datad : out std_logic_vector(32 - 1 downto 0)         -- -           / rd         / rd           / rd
            );
    end component branch_predictor;
    
    component clk_wiz_0 is
        port (
              --Clock out ports
              clk_out1 : out std_logic;
              clk_out2 : out std_logic;
              --Status and control signals
              reset : in std_logic;
              locked : out std_logic;
              --Clock in ports
              clk_in1 : in std_logic
              );
    end component clk_wiz_0;
    
    component text_screen_top is
       port(
          clk,reset: in std_logic;
          adress: in std_logic_vector (32 - 1 downto 0);
          data :in std_logic_vector (32 - 1 downto 0);
          hsync, vsync: out  std_logic;
          rgb: out std_logic_vector(12 - 1 downto 0)
       );
    end component text_screen_top;
           
    component wait_cpu_auto is
        port (
              clk   : in  std_logic;
              reset : in  std_logic;
              data  : in  std_logic;
              sleep : out std_logic
              );
    end component wait_cpu_auto;
          
    component branch_auto is
        port (
              reset   : in  std_logic;
              set_adress : in  std_logic;
              clk  : in  std_logic;
              mk_nop : out std_logic
              );
    end component branch_auto;

begin
	sel_bit <= func7(5);
	reset_inv <= NOT reset;
	reset_l <= (NOT lock) and reset_inv;
	--clk1out <= clk1;
	--clk2out <= clk2;
	--jump <= radr_pc;
	write_ram <= "1" when write_enable_ram = '1' else
	             "0";
	
	alu_c : alu
	port map (data1 => data1,
			  data2 => data2,
			  data_out => alu_register,
			  func3 => func3,
			  is_imm => imm_select,
			  selector_bit => sel_bit);

	alu_mult_c : alu_in_mult
	port map (reg_in => reg_data,
			  imm_in => imm_data,
			  selector => imm_select,
			  data_out => data2);

	id_c : instruction_decoder
	port map (instruction => instruction,
	          rs1 => reg1,
			  rs2 => reg2,
			  rd => regout,
			  rwrite => write_enable,
			  selector => selector_reg,
              selector_bra => selector_bra,
			  funct3 => func3,
			  funct7 => func7,
			  imm_select => imm_select,
			  imm_out => imm_data,
			  ram_offset => ram_offset,
			  ram_width => ram_width,
			  ram_r_w => write_enable_ram_io,
			  pc_r_w => write_enable_pc,
			  to_register => from_id,
			  halt_cpu => change_state,
			  clk => clk1,
			  stop_cpu => stop_cpu
			  
			  );

	r_c : registerfile
	port map(writeenable => write_enable,
	         wAdr => regout,
	         clk => clk1,
			 rAdr_1 => reg1,
			 rAdr_2 => reg2,
			 rData_1 => data1,
			 rData_2 => reg_data,
			 wData => dataout);
			 
    if_c : instruction_fetch
    port map(inst_in_adress => radr_pc,
             inst_out_adress => padr_ram,
             inst_in_code => pdata_ram,
             inst_out_code => instruction,
             stop_cpu => stop_cpu,
             mk_nop => mk_nop
             );
    
    ram_mult_c : ram_io_mult
    port map(r_w => write_enable_ram_io,
             r_w_ram => write_enable_ram,
             r_w_io => write_enable_io,
             offset => ram_offset,
             width => ram_width,
             from_register_adress => data1,
             from_register_data => data2,
             to_ram_adress => radr_ram,
             to_ram_data => wdata_ram,
             from_ram_data => rdata_ram,
             to_register_data => ram_register,
             to_io_adress => adr_io,
             to_io_data => wdata_io,
             from_io_data => rdata_io,
             to_display => data,
             to_display_data => to_display_data
             );
    
    pc_c : programm_counter
    port map(clk => clk1,
             inst_in_adress => wadr_pc,
             set_adress => set_adress,
             reset => reset_l,
             inst_out_adress => radr_pc,
             stop_cpu => stop_cpu
             );
    
    ram_c : ram2
    port map(writeEnableB => write_enable_ram,
             adrB => radr_ram,
             clk => clk1,
             dInB => wdata_ram,
             adrA => padr_ram,
             dOutB => rdata_ram,
             dOutA => pdata_ram
             );
             
--    ram_c : blk_mem_gen_0
--    PORT MAP (
--              clka => clk1,
--              wea => (others => '0'),
--              addra => padr_ram,
--              dina => (others => '0'),
--              douta => pdata_ram,
--              clkb => clk1,
--              web => write_ram,
--              addrb => radr_ram,
--              dinb => wdata_ram,
--              doutb => rdata_ram
--              );
             
    io_mult_c : io_mult
    port map(io_rw => write_enable_io,
             io_adress => adr_io,
             io_to_data => wdata_io,
             io_from_data => rdata_io,
             write => write_io,
             data_io_0 => data_io_0,
             data_io_1 => data_io_1
             );
     
    register_mult_c : register_mult
    port map(to_register => dataout,
             from_ram_io => ram_register,
             from_alu => alu_register,
             from_pc => from_bp,
             from_id => from_id,
             selector => selector_reg
            );
        
    output_io_c: output
    port map (clk => clk1,
              reset => reset_l,
              write => write_io,
              data_in => data_io_0,
              data_out => led);
    
    debouncer_io_c: debouncer_32
    port map (clk => clk1,
              data_in => switch,
              data_out => data_io_1);
              
    branch_predictor_c: branch_predictor
    port map (data1 => data1,
              data2 => data2,
              r1 => reg1,
              r2 => reg2,
              rd => regout,
              funct7 => func7,
              funct3 => func3,
              pc_in => radr_pc,
              selector_bra => selector_bra,
              pc_out => wadr_pc,
              set_adress => set_adress,
              datad => from_bp,
              write_enable_pc => write_enable_pc);
     
     
     clock_c : clk_wiz_0
     port map (
                   clk_out1 => clk1,
                   clk_out2 => clk2,
                   reset => reset_inv,
                   locked => lock,
                   clk_in1 => clk100Mhz
                   );
                   
     display_text_c : text_screen_top
     port map (
                   clk => clk1,
                   reset => reset_l,
                   hsync => hsync,
                   vsync => vsync,
                   rgb => rgb,
                   data => to_display_data,
                   adress => data

                   );
                   
     wait_cpu_auto_c : wait_cpu_auto
     port map (
                clk => clk1,
                reset => reset_l,
                data => change_state,
                sleep => stop_cpu
                );
                
     branch_auto_c : branch_auto
     port map (
                clk => clk1,
                reset => reset_l,
                set_adress => set_adress,
                mk_nop => mk_nop
                );
    
end Structual;
