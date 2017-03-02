LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

	--Define The Core Entity
ENTITY myArkanoidVHDL IS
PORT(   
		--Counter/VGA Timing
		clk		: IN STD_LOGIC;
		paddleGoRight: IN STD_LOGIC;
		paddleGoLeft: IN STD_LOGIC;
		startPauseGame: IN STD_LOGIC;
		resetGame: IN STD_LOGIC;
		--VGA Signals/Pins (Outputs)
		hsync,
		vsync,
		red0, 
		green0,
		blue0,		
		red1, 
		green1,
		blue1,
		red2, 
		green2,
		blue2,		
		red3, 
		green3,
		blue3   	: OUT STD_LOGIC;
				
	leds1 : out std_logic_vector(6 downto 0); -- uscita 7 bit x 7 segmenti
	leds2 : out std_logic_vector(6 downto 0); -- uscita 7 bit x 7 segmenti
	leds3 : out std_logic_vector(6 downto 0); -- uscita 7 bit x 7 segmenti
	leds4 : out std_logic_vector(6 downto 0)); -- uscita 7 bit x 7 segmenti		
		
		
		
		--Sync Counters
		--row,
		--column	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
end  myArkanoidVHDL;

	--Define The Architecture Of The Entity
ARCHITECTURE behavior of  myArkanoidVHDL IS
		
			--Sync Signals
SIGNAL 	h_sync, v_sync	:	STD_LOGIC;
			--Video Enables
SIGNAL 	video_en, 
		horizontal_en, 
		vertical_en	: STD_LOGIC;
			--Color Signals
SIGNAL	red0_signal,
		green0_signal,
		blue0_signal,
		red1_signal,
		green1_signal,
		blue1_signal,
		red2_signal,
		green2_signal,
		blue2_signal,
		red3_signal,
		green3_signal,
		blue3_signal	: STD_LOGIC;
			--Sync Counters
SIGNAL 	h_cnt, 
		v_cnt : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN
	
	video_en <= horizontal_en AND vertical_en;
	
PROCESS
--variable cnt: integer range 0 to 25000000;
variable ballPositionV: integer:=250;
variable ballPositionH: integer:=250;
variable cntPaddleSpeed: integer range 0 to 10000000;
variable ballMovementH: integer :=1;
variable ballMovementV: integer :=1;
variable oldBallMovementV: integer :=1;
variable oldBallMovementH: integer :=1;

variable gameOver: integer :=0;
variable cntBallSpeed: integer range 0 to 10000000;
variable cntScrittaLampeggiante: integer range 0 to 16000000;
variable scrittaLampeggia: STD_LOGIC;
variable paddleHorizontalDimension: integer :=60;
variable paddleLeftCorner: integer := 290;
variable paddleRightCorner: integer :=350;
variable arkanoid_a_Position: integer :=250;
variable arkanoid_r_Position: integer :=256;
variable arkanoid_k_Position: integer :=262;
variable arkanoid_a2_Position: integer :=268;
variable arkanoid_n_Position: integer :=274;
variable arkanoid_o_Position: integer :=280;
variable arkanoid_i_Position: integer :=286;
variable arkanoid_d_Position: integer :=292;
variable onAlterade1_o_Position: integer :=304;
variable onAlterade1_n_Position: integer :=310;
variable onAlterade1_a_Position: integer :=322;
variable onAlterade1_l_Position: integer :=328;
variable onAlterade1_t_Position: integer :=334;
variable onAlterade1_e_Position: integer :=340;
variable onAlterade1_r_Position: integer :=346;
variable onAlterade1_a2_Position: integer :=352;
variable onAlterade1_d_Position: integer :=364;
variable onAlterade1_e2_Position: integer :=370;
variable onAlterade1_1_Position: integer :=376;



variable Pause_p_Position: integer :=300;
variable Pause_a_Position: integer :=306;
variable Pause_u_Position: integer :=312;
variable Pause_s_Position: integer :=318;
variable Pause_e_Position: integer :=324;

variable gameOver_g_Position: integer :=282;
variable gameOver_a_Position: integer :=288;
variable gameOver_m_Position: integer :=294;
variable gameOver_e_Position: integer :=300;
variable gameOver_o_Position: integer :=312;
variable gameOver_v_Position: integer :=318;
variable gameOver_e2_Position: integer :=324;
variable gameOver_r_Position: integer :=330;
variable youWin_y_Position: integer :=288;
variable youWin_o_Position: integer :=294;
variable youWin_u_Position: integer :=300;
variable youWin_w_Position: integer :=312;
variable youWin_i_Position: integer :=318;
variable youWin_n_Position: integer :=324;
variable youWin_e_Position: integer :=330;
variable gazzinMatteo_g_Position: integer :=10;
variable gazzinMatteo_a_Position: integer :=16;
variable gazzinMatteo_z_Position: integer :=22;
variable gazzinMatteo_z2_Position: integer :=28;
variable gazzinMatteo_i_Position: integer :=34;
variable gazzinMatteo_n_Position: integer :=40;
variable gazzinMatteo_m_Position: integer :=52;
variable gazzinMatteo_a2_Position: integer :=58;
variable gazzinMatteo_t_Position: integer :=64;
variable gazzinMatteo_t2_Position: integer :=70;
variable gazzinMatteo_e_Position: integer :=76;
variable gazzinMatteo_o_Position: integer :=82;
variable units_u_Position: integer :=94;
variable units_n_Position: integer :=100;
variable units_i_Position: integer :=106;
variable units_t_Position: integer :=112;
variable units_s_Position: integer :=118;
variable elettronica2fpga_e_Position: integer :=522;
variable elettronica2fpga_l_Position: integer :=528;
variable elettronica2fpga_e2_Position: integer :=534;
variable elettronica2fpga_t_Position: integer :=540;
variable elettronica2fpga_t2_Position: integer :=546;
variable elettronica2fpga_r_Position: integer :=552;
variable elettronica2fpga_o_Position: integer :=558;
variable elettronica2fpga_n_Position: integer :=564;
variable elettronica2fpga_i_Position: integer :=570;
variable elettronica2fpga_c_Position: integer :=576;
variable elettronica2fpga_a_Position: integer :=582;
variable elettronica2fpga_2_Position: integer :=594;
variable elettronica2fpga_f_Position: integer :=606;
variable elettronica2fpga_p_Position: integer :=612;
variable elettronica2fpga_g_Position: integer :=618;
variable elettronica2fpga_a2_Position: integer :=624;			


variable leftBorder:integer :=30;
variable rightBorder:integer :=630;
variable upBorder: integer :=70;


variable angle: integer :=1;

variable ballSpeed: integer:=200000; --MAX 10000000 pi� grande �, pi� lenta va.
variable waitOneSecond: integer:=0; --MAX 10000000 pi� grande �, pi� lenta va.
variable second: STD_LOGIC :='0';
variable waitForStart: STD_LOGIC :='0';

variable numberOfObstacles: integer:=10;
type STD_LOGIC_ARRAY is array(numberOfObstacles downto 0) of STD_LOGIC;
variable obstacles : STD_LOGIC_ARRAY;
variable punteggio: integer:=0;
variable youWin: STD_LOGIC:='0';
variable vite: integer :=3;
type INT_ARRAY is array(numberOfObstacles downto 0) of integer;
variable obstacle_w : INT_ARRAY;
variable obstacle_e : INT_ARRAY;
variable obstacle_n : INT_ARRAY;
variable obstacle_s : INT_ARRAY;

type STD_LOGIC_COLOR_ARRAY is array(5 downto 0) of STD_LOGIC;

variable ballDirectionIsRight: STD_LOGIC:='1';
variable waterPeriod:integer:=0;
variable water_surface:integer:=440;

BEGIN
WAIT UNTIL(clk'EVENT) AND (clk = '1');
	--IF(startGame = '1') THEN
		
		--IF(cnt = 25000000)THEN	 
		--		cnt := 0;
		--	ELSE	
		--		cnt := cnt  + 1;
		--END IF;
		IF(cntScrittaLampeggiante = 10000000)THEN	
				cntScrittaLampeggiante := 0;
				scrittaLampeggia :=NOT scrittaLampeggia;
				
			ELSE	
				cntScrittaLampeggiante := cntScrittaLampeggiante  + 1;
				
		END IF;
		IF (waitForStart ='1') THEN
			IF(waitOneSecond = 50000000)THEN	 
					waitOneSecond := 0;
					second:='1';
				ELSE	
					waitOneSecond := waitOneSecond  + 1;
			END IF;
		END IF;
		
		IF (resetGame='1') THEN
		--tutto come all'inizio.
		ballPositionH:=250;
		ballPositionV:=250;
		paddleLeftCorner:=290;
		paddleRightCorner:=350;
		ballMovementH:=1;
		ballMovementV:=1;
		gameOver :=0; 
		angle:=1;
		punteggio:=0;
		vite:=3;
		waitForStart:='0';
		youWin:='0';
		leds1<="0000000";
		leds2<="0000000";
		leds3<="0000000";
		leds4<="0000000";	
		

		--obstacle3
				--obstacle3
			obstacles(0):='1';
			--obstacle4
			obstacles(1):='1';
			--obstacle5
			obstacles(2):='1';
			--obstacles
			obstacles(3):='1';
			--obstacle7
			obstacles(4):='1';
			obstacles(5):='1';
			--obstacle4
			obstacles(6):='1';
			--obstacle5
			obstacles(7):='1';
			--obstacle8
			obstacles(8):='1';
			--obstacle9
			obstacles(9):='1';
			--obstacle10
			obstacles(10):='1';
		--obstacle3
			obstacle_w(0):=276;
			obstacle_e(0):=325;
			obstacle_n(0):=151;
			obstacle_s(0):=160;
			--obstacle4
			
			obstacle_w(1):=251;
			obstacle_e(1):=300;
			obstacle_n(1):=161;
			obstacle_s(1):=170;
			--obstacle5
			obstacle_w(2):=301;
			obstacle_e(2):=350;
			obstacle_n(2):=161;
			obstacle_s(2):=170;
			--obstacles
			obstacle_w(3):=351;
			obstacle_e(3):=400;
			obstacle_n(3):=161;
			obstacle_s(3):=170;
			--obstacle7
			
			obstacle_w(4):=326;
			obstacle_e(4):=375;
			obstacle_n(4):=151;
			obstacle_s(4):=160;
			
			obstacle_w(5):=201;
			obstacle_e(5):=250;
			obstacle_n(5):=171;
			obstacle_s(5):=180;
			--obstacle4
			obstacle_w(6):=251;
			obstacle_e(6):=300;
			obstacle_n(6):=171;
			obstacle_s(6):=180;
			--obstacle5
			obstacle_w(7):=301;
			obstacle_e(7):=350;
			obstacle_n(7):=171;
			obstacle_s(7):=180;
			--obstacle8
			obstacle_w(8):=351;
			obstacle_e(8):=400;
			obstacle_n(8):=171;
			obstacle_s(8):=180;
			--obstacle9
			obstacle_w(9):=401;
			obstacle_e(9):=450;
			obstacle_n(9):=171;
			obstacle_s(9):=180;
			--obstacle10
			obstacle_w(10):=301;
			obstacle_e(10):=350;
			obstacle_n(10):=141;
			obstacle_s(10):=150;
		END IF;
		
			case vite is
					when 0 => leds1 <= "0111111";--	leds2 <= "0000000";	leds3 <= "0000000";	leds4 <= "0000000";	 --0c
					when 1 => leds1 <="0000110"; --	leds2 <= "0000000";	leds3 <= "0000000";	leds4 <= "0000000";	 --5c
					when 2 => leds1 <= "1011011";--	leds2 <= "0000110";	leds3 <= "0000000";	leds4 <= "0000000"; --10c
					when 3 => leds1 <="1001111"; --	leds2 <= "0000110";	leds3 <= "0000000";	leds4 <= "0000000";	 --15c
					when others => NULL;
				end case;
		
		
		IF (punteggio = numberOfObstacles+1) THEN
			youWin:='1';
		END IF;
		IF(startPauseGame='1' AND youWin='0') THEN
		--cntPaddleSpeed contatore per determinare la velocit� della barretta. pi� alto � il valore a destra dell'uguale, pi� lenta � la barretta.
		IF(cntPaddleSpeed = 75000)THEN
			cntPaddleSpeed:=0;
			IF(paddleGoRight = '0') THEN
				if (paddleRightCorner = 615) THEN
						paddleLeftCorner:=paddleLeftCorner;
					else paddleLeftCorner := paddleLeftCorner+1;
				end if;	
			
			ELSIF (paddleGoLeft = '0') THEN
				if (paddleLeftCorner = 35) THEN
						paddleLeftCorner:=35;
					else paddleLeftCorner := paddleLeftCorner-1;
					end if;
					
			END IF;
		ELSE
			cntPaddleSpeed:=cntPaddleSpeed+1;
		END IF;
		paddleRightCorner :=paddleLeftCorner+paddleHorizontalDimension;
		--cntBallSpeed contatore per determinare la velocit� della pallina. pi� alto � il valore a destra dell'uguale, pi� lenta � la pallina.
		
			IF(cntBallSpeed = ballSpeed) THEN
				cntBallSpeed:=0;
		--movimento pallina verticale
				IF(ballMovementV = 1) THEN
						--Pallina Colpisce fondo schermo -->Game OVER
						if (ballPositionV >= 450 AND ballPositionV <= 456) THEN
							oldBallMovementV:=ballMovementV;
							oldBallMovementH:=ballMovementH;
							ballMovementV:=2;--STOP
							ballMovementH:=2;--STOP
							ballPositionV:=450;
							vite:=vite-1;
							waitForStart:='1';
						end if;
						
						--COLLISIONE BLOCCHI
							FOR i IN 0 TO numberOfObstacles LOOP
								IF ((ballPositionV+11 >= obstacle_n(i) AND ballPositionV+11 <= obstacle_s(i) AND ballPositionH>=obstacle_w(i) AND ballPositionH<=obstacle_e(i) AND obstacles(i)='1') OR
									(ballPositionV+11 >= obstacle_n(i) AND ballPositionV+11 <= obstacle_s(i) AND ballPositionH-3>=obstacle_w(i) AND ballPositionH-3<=obstacle_e(i) AND obstacles(i)='1') OR
									(ballPositionV+11 >= obstacle_n(i) AND ballPositionV+11 <= obstacle_s(i) AND ballPositionH+2>=obstacle_w(i) AND ballPositionH+2<=obstacle_e(i) AND obstacles(i)='1') OR
									(ballPositionV+10 >= obstacle_n(i) AND ballPositionV+10 <= obstacle_s(i) AND ballPositionH-4>=obstacle_w(i) AND ballPositionH-4<=obstacle_e(i) AND obstacles(i)='1') OR
									(ballPositionV+10 >= obstacle_n(i) AND ballPositionV+10 <= obstacle_s(i) AND ballPositionH+3>=obstacle_w(i) AND ballPositionH+3<=obstacle_e(i) AND obstacles(i)='1') OR
									(ballPositionV+9 <= obstacle_n(i) AND ballPositionV+9 >= obstacle_s(i) AND ballPositionH-5>=obstacle_w(i) AND ballPositionH-5<=obstacle_e(i) AND obstacles(i)='1') OR 
									(ballPositionV+9 <= obstacle_n(i) AND ballPositionV+9 >= obstacle_s(i) AND ballPositionH+4>=obstacle_w(i) AND ballPositionH+4<=obstacle_e(i) AND obstacles(i)='1') OR 
									(ballPositionV+8 <= obstacle_n(i) AND ballPositionV+8 >= obstacle_s(i) AND ballPositionH-5>=obstacle_w(i) AND ballPositionH-5<=obstacle_e(i) AND obstacles(i)='1') OR 
									(ballPositionV+8 <= obstacle_n(i) AND ballPositionV+8 >= obstacle_s(i) AND ballPositionH+4>=obstacle_w(i) AND ballPositionH+4<=obstacle_e(i) AND obstacles(i)='1') OR 								
									(ballPositionV+7 <= obstacle_n(i) AND ballPositionV+7 >= obstacle_s(i) AND ballPositionH-6>=obstacle_w(i) AND ballPositionH-6<=obstacle_e(i) AND obstacles(i)='1') OR 
									(ballPositionV+7 <= obstacle_n(i) AND ballPositionV+7 >= obstacle_s(i) AND ballPositionH+5>=obstacle_w(i) AND ballPositionH+5<=obstacle_e(i) AND obstacles(i)='1') )
								THEN
									ballMovementV:=0;
									ballPositionV:=ballPositionV+1;		
									obstacles(i):='0';
									punteggio:=punteggio+1;
								END IF;

							END LOOP;
							
							IF ((ballPositionV+11 >=195) AND (ballPositionV+11 <= 204) AND (ballPositionH >= 61) AND (ballPositionH <= 110)) OR 
								((ballPositionV+11 >=185) AND (ballPositionV+11 <= 194) AND (ballPositionH >= 211) AND (ballPositionH <= 260)) OR
								((ballPositionV+11 >=195) AND (ballPositionV+11 <= 204) AND (ballPositionH >= 305) AND (ballPositionH <= 354)) OR
								((ballPositionV+11 >=185) AND (ballPositionV+11 <= 194) AND (ballPositionH >= 401) AND (ballPositionH <= 450)) OR
								((ballPositionV+11 >=195) AND (ballPositionV+11 <= 204) AND (ballPositionH >= 551) AND (ballPositionH <= 600)) THEN
									ballMovementV:=0;
									ballPositionV:=ballPositionV+1;		
							END IF;
							
						--/COLLISIONE BLOCCHI						
						if (ballPositionV >= 420 and ballPositionV <= 425) AND (ballPositionH>=paddleLeftCorner+3 OR ballPositionH+2>=paddleLeftCorner+3) AND (ballPositionH<=paddleRightCorner-3 OR ballPositionH-3<=paddleRightCorner-3)THEN
							--effetto pallina
							
								IF( paddleGoRight='0' AND ballDirectionIsRight='1' ) THEN
									IF(angle<3) THEN
										angle:=angle+1;
										--ballSpeed:=ballSpeed+100000;
									ELSE angle:=3;
									END IF;
								END IF;
								IF(paddleGoRight='0' AND ballDirectionIsRight='0' ) THEN
									IF(angle>1) THEN
										angle:=angle-1;
										--ballSpeed:=ballSpeed-100000;
									ELSE angle:=angle;
									END IF;
								END IF;
								IF(paddleGoLeft='0' AND ballDirectionIsRight='1' ) THEN
									IF(angle>1) THEN
										angle:=angle-1;
										--ballSpeed:=ballSpeed-100000;
									ELSE angle:=angle;
									END IF;
								END IF;
								IF( paddleGoLeft='0' AND ballDirectionIsRight='0' ) THEN
									IF(angle<3) THEN
										angle:=angle+1;
										--ballSpeed:=ballSpeed+100000;

									ELSE angle:=3;
									END IF;
								END IF;							
								--/effetto pallina
							

							--nessun effetto
							ballMovementV:=0;
						else ballPositionV:=ballPositionV+angle;
						end if;
						--collisione angoli paddle
						if ((ballPositionV+9 = 430 AND ballPositionH+4>=paddleLeftCorner+3 AND ballPositionH+4<=paddleLeftCorner+6) OR 
								(ballPositionV+9 = 431 AND ballPositionH+4>=paddleLeftCorner+2 AND ballPositionH+4<=paddleLeftCorner+5) OR
								(ballPositionV+9 = 432 AND ballPositionH+4>=paddleLeftCorner+1 AND ballPositionH+4<=paddleLeftCorner+4) OR
								(ballPositionV+9 = 433 AND ballPositionH+4>=paddleLeftCorner AND ballPositionH+4<=paddleLeftCorner+3) OR
								(ballPositionV+9 = 434 AND ballPositionH+4>=paddleLeftCorner-1 AND ballPositionH+4<=paddleLeftCorner+2) OR
								(ballPositionV+9 = 435 AND ballPositionH+4>=paddleLeftCorner-2 AND ballPositionH+4<=paddleLeftCorner+1) OR
								(ballPositionV+9 = 436 AND ballPositionH+4>=paddleLeftCorner-3 AND ballPositionH+4<=paddleLeftCorner) OR
								(ballPositionV+9 = 437 AND ballPositionH+4>=paddleLeftCorner-4 AND ballPositionH+4<=paddleLeftCorner-1) OR
								(ballPositionV+9 = 438 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
								(ballPositionV+9 = 439 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
								(ballPositionV+9 = 440 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
						
								(ballPositionV+8 = 430 AND ballPositionH+4>=paddleLeftCorner+3 AND ballPositionH+4<=paddleLeftCorner+6) OR 
								(ballPositionV+8 = 431 AND ballPositionH+4>=paddleLeftCorner+2 AND ballPositionH+4<=paddleLeftCorner+5) OR
								(ballPositionV+8 = 432 AND ballPositionH+4>=paddleLeftCorner+1 AND ballPositionH+4<=paddleLeftCorner+4) OR
								(ballPositionV+8 = 433 AND ballPositionH+4>=paddleLeftCorner AND ballPositionH+4<=paddleLeftCorner+3) OR
								(ballPositionV+8 = 434 AND ballPositionH+4>=paddleLeftCorner-1 AND ballPositionH+4<=paddleLeftCorner+2) OR
								(ballPositionV+8 = 435 AND ballPositionH+4>=paddleLeftCorner-2 AND ballPositionH+4<=paddleLeftCorner+1) OR
								(ballPositionV+8 = 436 AND ballPositionH+4>=paddleLeftCorner-3 AND ballPositionH+4<=paddleLeftCorner) OR
								(ballPositionV+8 = 437 AND ballPositionH+4>=paddleLeftCorner-4 AND ballPositionH+4<=paddleLeftCorner-1) OR
								(ballPositionV+8 = 438 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
								(ballPositionV+8 = 439 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
								(ballPositionV+8 = 440 AND ballPositionH+4>=paddleLeftCorner-5 AND ballPositionH+4<=paddleLeftCorner-2) OR
								
								(ballPositionV+7 = 430 AND ballPositionH+5>=paddleLeftCorner+3 AND ballPositionH+5<=paddleLeftCorner+6) OR 
								(ballPositionV+7 = 431 AND ballPositionH+5>=paddleLeftCorner+2 AND ballPositionH+5<=paddleLeftCorner+5) OR
								(ballPositionV+7 = 432 AND ballPositionH+5>=paddleLeftCorner+1 AND ballPositionH+5<=paddleLeftCorner+4) OR
								(ballPositionV+7 = 433 AND ballPositionH+5>=paddleLeftCorner AND ballPositionH+5<=paddleLeftCorner+3) OR
								(ballPositionV+7 = 434 AND ballPositionH+5>=paddleLeftCorner-1 AND ballPositionH+5<=paddleLeftCorner+2) OR
								(ballPositionV+7 = 435 AND ballPositionH+5>=paddleLeftCorner-2 AND ballPositionH+5<=paddleLeftCorner+1) OR
								(ballPositionV+7 = 436 AND ballPositionH+5>=paddleLeftCorner-3 AND ballPositionH+5<=paddleLeftCorner) OR
								(ballPositionV+7 = 437 AND ballPositionH+5>=paddleLeftCorner-4 AND ballPositionH+5<=paddleLeftCorner-1) OR
								(ballPositionV+7 = 438 AND ballPositionH+5>=paddleLeftCorner-5 AND ballPositionH+5<=paddleLeftCorner-2) OR
								(ballPositionV+7 = 439 AND ballPositionH+5>=paddleLeftCorner-5 AND ballPositionH+5<=paddleLeftCorner-2) OR
								(ballPositionV+7 = 440 AND ballPositionH+5>=paddleLeftCorner-5 AND ballPositionH+5<=paddleLeftCorner-2) OR
								
								(ballPositionV+10 = 430 AND ballPositionH+3>=paddleLeftCorner+3 AND ballPositionH+3<=paddleLeftCorner+6) OR 
								(ballPositionV+10 = 431 AND ballPositionH+3>=paddleLeftCorner+2 AND ballPositionH+3<=paddleLeftCorner+5) OR
								(ballPositionV+10 = 432 AND ballPositionH+3>=paddleLeftCorner+1 AND ballPositionH+3<=paddleLeftCorner+4) OR
								(ballPositionV+10 = 433 AND ballPositionH+3>=paddleLeftCorner AND ballPositionH+3<=paddleLeftCorner+3) OR
								(ballPositionV+10 = 434 AND ballPositionH+3>=paddleLeftCorner-1 AND ballPositionH+3<=paddleLeftCorner+2) OR
								(ballPositionV+10 = 435 AND ballPositionH+3>=paddleLeftCorner-2 AND ballPositionH+3<=paddleLeftCorner+1) OR
								(ballPositionV+10 = 436 AND ballPositionH+3>=paddleLeftCorner-3 AND ballPositionH+3<=paddleLeftCorner) OR
								(ballPositionV+10 = 437 AND ballPositionH+3>=paddleLeftCorner-4 AND ballPositionH+3<=paddleLeftCorner-1) OR
								(ballPositionV+10 = 438 AND ballPositionH+3>=paddleLeftCorner-5 AND ballPositionH+3<=paddleLeftCorner-2) OR
								(ballPositionV+10 = 439 AND ballPositionH+3>=paddleLeftCorner-5 AND ballPositionH+3<=paddleLeftCorner-2) OR
								(ballPositionV+10 = 440 AND ballPositionH+3>=paddleLeftCorner-5 AND ballPositionH+3<=paddleLeftCorner-2)
						) THEN
							
							
								ballMovementV:=0;	
								ballMovementH:=0;
						
						end if;
						
						
						if ((ballPositionV+9 = 430 AND ballPositionH-5>=paddleRightCorner-6 AND ballPositionH-5<=paddleRightCorner-3) OR 
								(ballPositionV+9 = 431 AND ballPositionH-5>=paddleRightCorner-5  AND ballPositionH-5<=paddleRightCorner-2) OR
								(ballPositionV+9 = 432 AND ballPositionH-5>=paddleRightCorner-4  AND ballPositionH-5<=paddleRightCorner-1) OR
								(ballPositionV+9 = 433 AND ballPositionH-5>=paddleRightCorner-3  AND ballPositionH-5<=paddleRightCorner) OR
								(ballPositionV+9 = 434 AND ballPositionH-5>=paddleRightCorner-2  AND ballPositionH-5<=paddleRightCorner+1) OR
								(ballPositionV+9 = 435 AND ballPositionH-5>=paddleRightCorner-1 AND ballPositionH-5<=paddleRightCorner+2 )OR
								(ballPositionV+9 = 436 AND ballPositionH-5>=paddleRightCorner  AND ballPositionH-5<=paddleRightCorner+3 )OR
								(ballPositionV+9 = 437 AND ballPositionH-5>=paddleRightCorner+1  AND ballPositionH-5<=paddleRightCorner+4 )OR
								(ballPositionV+9 = 438 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								(ballPositionV+9 = 439 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								(ballPositionV+9 = 440 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								
								(ballPositionV+8 = 430 AND ballPositionH-5>=paddleRightCorner-6 AND ballPositionH-5<=paddleRightCorner-3) OR 
								(ballPositionV+8 = 431 AND ballPositionH-5>=paddleRightCorner-5  AND ballPositionH-5<=paddleRightCorner-2) OR
								(ballPositionV+8 = 432 AND ballPositionH-5>=paddleRightCorner-4  AND ballPositionH-5<=paddleRightCorner-1) OR
								(ballPositionV+8 = 433 AND ballPositionH-5>=paddleRightCorner-3  AND ballPositionH-5<=paddleRightCorner) OR
								(ballPositionV+8 = 434 AND ballPositionH-5>=paddleRightCorner-2  AND ballPositionH-5<=paddleRightCorner+1) OR
								(ballPositionV+8 = 435 AND ballPositionH-5>=paddleRightCorner-1 AND ballPositionH-5<=paddleRightCorner+2 )OR
								(ballPositionV+8 = 436 AND ballPositionH-5>=paddleRightCorner  AND ballPositionH-5<=paddleRightCorner+3 )OR
								(ballPositionV+8 = 437 AND ballPositionH-5>=paddleRightCorner+1  AND ballPositionH-5<=paddleRightCorner+4 )OR
								(ballPositionV+8 = 438 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								(ballPositionV+8 = 439 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								(ballPositionV+8 = 440 AND ballPositionH-5>=paddleRightCorner+2 AND ballPositionH-5<=paddleRightCorner+5 )OR
								
								
								(ballPositionV+7 = 430 AND ballPositionH-6>=paddleRightCorner-6 AND ballPositionH-6<=paddleRightCorner-3) OR 
								(ballPositionV+7 = 431 AND ballPositionH-6>=paddleRightCorner-5  AND ballPositionH-6<=paddleRightCorner-2) OR
								(ballPositionV+7 = 432 AND ballPositionH-6>=paddleRightCorner-4  AND ballPositionH-6<=paddleRightCorner-1) OR
								(ballPositionV+7 = 433 AND ballPositionH-6>=paddleRightCorner-3  AND ballPositionH-6<=paddleRightCorner) OR
								(ballPositionV+7 = 434 AND ballPositionH-6>=paddleRightCorner-2  AND ballPositionH-6<=paddleRightCorner+1) OR
								(ballPositionV+7 = 435 AND ballPositionH-6>=paddleRightCorner-1 AND ballPositionH-6<=paddleRightCorner+2 )OR
								(ballPositionV+7 = 436 AND ballPositionH-6>=paddleRightCorner  AND ballPositionH-6<=paddleRightCorner+3 )OR
								(ballPositionV+7 = 437 AND ballPositionH-6>=paddleRightCorner+1  AND ballPositionH-6<=paddleRightCorner+4 )OR
								(ballPositionV+7 = 438 AND ballPositionH-6>=paddleRightCorner+2 AND ballPositionH-6<=paddleRightCorner+5 )OR
								(ballPositionV+7 = 439 AND ballPositionH-6>=paddleRightCorner+2 AND ballPositionH-6<=paddleRightCorner+5 )OR
								(ballPositionV+7 = 440 AND ballPositionH-6>=paddleRightCorner+2 AND ballPositionH-6<=paddleRightCorner+5 ) OR

								(ballPositionV+10 = 430 AND ballPositionH-3>=paddleRightCorner-6 AND ballPositionH-3<=paddleRightCorner-3) OR 
								(ballPositionV+10 = 431 AND ballPositionH-3>=paddleRightCorner-5  AND ballPositionH-3<=paddleRightCorner-2) OR
								(ballPositionV+10 = 432 AND ballPositionH-3>=paddleRightCorner-4  AND ballPositionH-3<=paddleRightCorner-1) OR
								(ballPositionV+10 = 433 AND ballPositionH-3>=paddleRightCorner-3  AND ballPositionH-3<=paddleRightCorner) OR
								(ballPositionV+10 = 434 AND ballPositionH-3>=paddleRightCorner-2  AND ballPositionH-3<=paddleRightCorner+1) OR
								(ballPositionV+10 = 435 AND ballPositionH-3>=paddleRightCorner-1 AND ballPositionH-3<=paddleRightCorner+2 )OR
								(ballPositionV+10 = 436 AND ballPositionH-3>=paddleRightCorner  AND ballPositionH-3<=paddleRightCorner+3 )OR
								(ballPositionV+10 = 437 AND ballPositionH-3>=paddleRightCorner+1  AND ballPositionH-3<=paddleRightCorner+4 )OR
								(ballPositionV+10 = 438 AND ballPositionH-3>=paddleRightCorner+2 AND ballPositionH-3<=paddleRightCorner+5 )OR
								(ballPositionV+10 = 439 AND ballPositionH-3>=paddleRightCorner+2 AND ballPositionH-3<=paddleRightCorner+5 )OR
								(ballPositionV+10 = 440 AND ballPositionH-3>=paddleRightCorner+2 AND ballPositionH-3<=paddleRightCorner+5 )
						
						)THEN
								
								ballMovementV:=0;	
								ballMovementH:=1;
						end if;
						--/collisione angoli paddle
				ELSIF(ballMovementV = 0) 	THEN
						if (ballPositionV >= upBorder-5 AND ballPositionV <= upBorder) THEN
							--ballPositionV:=30;
									ballMovementV:=1;
						else ballPositionV:=ballPositionV-angle;
						end if;
						--COLLISIONE BLOCCHI
							FOR i IN 0 TO numberOfObstacles LOOP
								if (( ballPositionV >= obstacle_n(i) AND ballPositionV <= obstacle_s(i) AND ballPositionH>=obstacle_w(i) AND ballPositionH<=obstacle_e(i)  AND obstacles(i)='1')OR  
									( ballPositionV >= obstacle_n(i) AND ballPositionV <= obstacle_s(i) AND ballPositionH-3>=obstacle_w(i) AND ballPositionH-3<=obstacle_e(i)  AND obstacles(i)='1')OR
									( ballPositionV >= obstacle_n(i) AND ballPositionV <= obstacle_s(i) AND ballPositionH+2>=obstacle_w(i) AND ballPositionH+2<=obstacle_e(i)  AND obstacles(i)='1')OR
									( ballPositionV+1 >= obstacle_n(i) AND ballPositionV+1 <= obstacle_s(i) AND ballPositionH-4>=obstacle_w(i) AND ballPositionH-4<=obstacle_e(i)  AND obstacles(i)='1')OR
									( ballPositionV+1 >= obstacle_n(i) AND ballPositionV+1 <= obstacle_s(i) AND ballPositionH+3>=obstacle_w(i) AND ballPositionH+3<=obstacle_e(i)  AND obstacles(i)='1')OR
									( ballPositionV+2 >= obstacle_n(i) AND ballPositionV+1 <= obstacle_s(i) AND ballPositionH-5>=obstacle_w(i) AND ballPositionH-5<=obstacle_e(i)  AND obstacles(i)='1')OR
									( ballPositionV+2 >= obstacle_n(i) AND ballPositionV+1 <= obstacle_s(i) AND ballPositionH+4>=obstacle_w(i) AND ballPositionH+4<=obstacle_e(i)  AND obstacles(i)='1')OR
									(ballPositionV+3 >= obstacle_n(i) AND ballPositionV+3 <= obstacle_s(i) AND ballPositionH-5>=obstacle_w(i) AND ballPositionH-5<=obstacle_e(i) AND obstacles(i)='1') OR 
									(ballPositionV+3 >= obstacle_n(i) AND ballPositionV+3 <= obstacle_s(i) AND ballPositionH+4>=obstacle_w(i) AND ballPositionH+4<=obstacle_e(i) AND obstacles(i)='1')OR 
									(ballPositionV+4 >= obstacle_n(i) AND ballPositionV+4 <= obstacle_s(i) AND ballPositionH-6>=obstacle_w(i) AND ballPositionH-6<=obstacle_e(i) AND obstacles(i)='1')OR
									(ballPositionV+4 >= obstacle_n(i) AND ballPositionV+4 <= obstacle_s(i) AND ballPositionH+5>=obstacle_w(i) AND ballPositionH+5<=obstacle_e(i) AND obstacles(i)='1')								
								)THEN
									ballMovementV:=1;
									ballPositionV:=ballPositionV-1;		
									obstacles(i):='0';
									punteggio:=punteggio+1;
								end if;
							END LOOP;
							
							IF ((ballPositionV >=195) AND (ballPositionV <= 204) AND (ballPositionH >= 61) AND (ballPositionH <= 110)) OR 
								((ballPositionV >=185) AND (ballPositionV <= 194) AND (ballPositionH >= 211) AND (ballPositionH <= 260)) OR
								((ballPositionV >=195) AND (ballPositionV <= 204) AND (ballPositionH >= 305) AND (ballPositionH <= 354)) OR
								((ballPositionV >=185) AND (ballPositionV <= 194) AND (ballPositionH >= 401) AND (ballPositionH <= 450)) OR
								((ballPositionV >=195) AND (ballPositionV <= 204) AND (ballPositionH >= 551) AND (ballPositionH <= 600)) THEN
									ballMovementV:=1;
									ballPositionV:=ballPositionV-1;		

							END IF;
							
						--/COLLISIONE BLOCCHI
						
						
												
				ELSE 
					ballPositionV:=ballPositionV;
					
					IF(vite=0) THEN
					gameOver:=1;
					ELSE
							ballPositionH:=250;
							ballPositionV:=250;
							paddleLeftCorner:=290;
							paddleRightCorner:=350;
							
							
						 IF(second ='1') THEN
							second:='0';
							waitOneSecond := 0;
							waitForStart :='0';
							IF(oldBallMovementH=0) THEN
								ballMovementH:=1;
							ELSIF(oldBallMovementH=1) THEN
								ballMovementH:=0;
							END IF;
							--IF(oldBallMovementV=0) THEN
							--	ballMovementV:=1;
							--ELSIF(oldBallMovementV=1) THEN
							--	ballMovementV:=0;
							--END IF;
							ballMovementV:=1;
							IF(angle=1)THEN
								angle:=2;
							ELSIF(angle=2)THEN
								angle:=1;
							ELSIF(angle=3)THEN
								angle:=2;
							END IF;
							
						--punteggioVisualizzato:=0;
						END IF;
					END IF;
				END IF;			
		--/movimento pallina verticale
		--movimento pallina orizzontale
				IF(ballMovementH = 1) THEN
						if (ballPositionH = rightBorder-10) THEN
							--ballPositionH:=630;
									ballMovementH:=0;
									ballPositionH:=ballPositionH-1;
						else ballPositionH:=ballPositionH+1;
						end if;
						--COLLISIONE BLOCCHI
							FOR i IN 0 TO numberOfObstacles LOOP
							if (ballPositionV>=obstacle_n(i) AND ballPositionV<=obstacle_s(i) AND ballPositionH+6=obstacle_w(i) AND obstacles(i)='1') THEN
									ballMovementH:=0;
									ballPositionH:=ballPositionH+1;	
									--obstacle1 := '0';	
									obstacles(i):='0';	
									punteggio:=punteggio+1;
							end if;			
							END LOOP;
						--/COLLISIONE BLOCCHI
							IF ((ballPositionV+5 >=195) AND (ballPositionV+5 <= 204) AND (ballPositionH+5 >= 61) AND (ballPositionH+5 <= 110)) OR 
								((ballPositionV+5 >=185) AND (ballPositionV+5 <= 194) AND (ballPositionH+5 >= 211) AND (ballPositionH+5 <= 260)) OR
								((ballPositionV+5 >=195) AND (ballPositionV+5 <= 204) AND (ballPositionH+5 >= 305) AND (ballPositionH+5 <= 354)) OR
								((ballPositionV+5 >=185) AND (ballPositionV+5 <= 194) AND (ballPositionH+5 >= 401) AND (ballPositionH+5 <= 450)) OR
								((ballPositionV+5 >=195) AND (ballPositionV+5 <= 204) AND (ballPositionH+5 >= 551) AND (ballPositionH+5 <= 600)) THEN
									ballMovementH:=0;
									ballPositionH:=ballPositionH+1;		
							END IF;
				ELSIF(ballMovementH = 0) THEN	
						if (ballPositionH = leftBorder) THEN
							--ballPositionH:=10;
									ballMovementH:=1;
									ballPositionH:=ballPositionH+1;
						else ballPositionH:=ballPositionH-1;
						end if;
						--COLLISIONE BLOCCHI
							FOR i IN 0 TO numberOfObstacles LOOP
								if (ballPositionV>=obstacle_n(i) AND ballPositionV<=obstacle_s(i) AND ballPositionH-6=obstacle_e(i) AND obstacles(i)='1') THEN
									ballMovementH:=1;
									ballPositionH:=ballPositionH-1;	
									--obstacle1 := '0';		
									obstacles(i):='0';
									punteggio:=punteggio+1;
								end if;	
							END LOOP;
						--/COLLISIONE BLOCCHI
							IF ((ballPositionV+5 >=195) AND (ballPositionV+5 <= 204) AND (ballPositionH-6 >= 61) AND (ballPositionH-6 <= 110)) OR 
								((ballPositionV+5 >=185) AND (ballPositionV+5 <= 194) AND (ballPositionH-6 >= 211) AND (ballPositionH -6<= 260)) OR
								((ballPositionV+5 >=185) AND (ballPositionV+5 <= 194) AND (ballPositionH-6 >= 305) AND (ballPositionH-6 <= 354)) OR
								((ballPositionV+5 >=185) AND (ballPositionV+5 <= 194) AND (ballPositionH-6 >= 401) AND (ballPositionH-6 <= 450)) OR
								((ballPositionV+5 >=195) AND (ballPositionV+5 <= 204) AND (ballPositionH-6 >= 551) AND (ballPositionH-6 <= 600)) THEN
									ballMovementH:=1;
									ballPositionH:=ballPositionH-1;		
							END IF;
				ELSE
					ballPositionH:=ballPositionH;
				END IF;	

			ELSE
				cntBallSpeed:=cntBallSpeed+1;
			END IF;
		END IF;

		--Horizontal Sync
		
			--Reset Horizontal Counter
		IF (h_cnt = 799) THEN
				h_cnt <= "0000000000";
			ELSE
				h_cnt <= h_cnt + 1;
		END IF;

			--Generate Horizontal Data
			--Sfondo
		IF (v_cnt >= 0) AND (v_cnt <= 479) THEN
			red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
			green3_signal <= '0'; 	green2_signal <= '0'; 	green1_signal <= '0'; 	green0_signal <= '0';
			blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
		END IF;

	--paddle drawing
		--clear screen
		IF (v_cnt >= 430) AND (v_cnt <= 440) AND (h_cnt >= paddleLeftCorner-1) AND (h_cnt <= paddleLeftCorner) THEN
			red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
			green3_signal <= '0'; 	green2_signal <= '0'; 	green1_signal <= '0'; 	green0_signal <= '0';
			blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
		END IF;
		--/clear screen	
		--paddle
			IF (v_cnt = 440) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';						
				END IF;
			IF (v_cnt = 439) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
			IF (v_cnt = 438) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';					
				END IF;
			IF (v_cnt = 437) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			IF (v_cnt = 436) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
			IF (v_cnt = 435) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';		
				END IF;
			IF (v_cnt = 434) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';				
				END IF;
			IF (v_cnt = 433) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			IF (v_cnt = 432) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';		
				END IF;
			IF (v_cnt = 431) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';	
				END IF;
			IF (v_cnt = 430) AND (h_cnt >= paddleLeftCorner+5) AND (h_cnt <= paddleRightCorner-5) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
										---
			IF (v_cnt = 430) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3)) THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';	
			END IF;
			iF (v_cnt = 431) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
								(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2))THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';			
			END IF;	
			IF (v_cnt = 432) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
								  (h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
								  (h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1))   THEN
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';				
			END IF;		
			IF (v_cnt = 433 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner))   THEN
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
			END IF;		
			IF (v_cnt = 433 ) AND (	(h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
									(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
									(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1))THEN
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
			END IF;				
			IF (v_cnt = 434 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
									(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
									(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
									(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
									(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1))   THEN
					
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
			END IF;		
			IF (v_cnt = 435 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2))   THEN
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';				
			END IF;	
			IF (v_cnt = 436 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2)OR
													(h_cnt = paddleLeftCorner-3) OR (h_cnt = paddleRightCorner+3))   THEN
						red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';				
			END IF;	
			IF (v_cnt = 437 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2)OR
													(h_cnt = paddleLeftCorner-3) OR (h_cnt = paddleRightCorner+3)OR
													(h_cnt = paddleLeftCorner-4) OR (h_cnt = paddleRightCorner+4))   THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';				
			END IF;	
			IF (v_cnt = 438 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2)OR
													(h_cnt = paddleLeftCorner-3) OR (h_cnt = paddleRightCorner+3)OR
													(h_cnt = paddleLeftCorner-4) OR (h_cnt = paddleRightCorner+4))   THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';				
			END IF;	
			IF (v_cnt = 439 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2)OR
													(h_cnt = paddleLeftCorner-3) OR (h_cnt = paddleRightCorner+3)OR
													(h_cnt = paddleLeftCorner-4) OR (h_cnt = paddleRightCorner+4))   THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
			END IF;	
			IF (v_cnt = 440 ) AND ((h_cnt = paddleLeftCorner+3) OR (h_cnt = paddleRightCorner-3) OR
													(h_cnt = paddleLeftCorner+2) OR (h_cnt = paddleRightCorner-2) OR
													(h_cnt = paddleLeftCorner+1) OR (h_cnt = paddleRightCorner-1) OR
													(h_cnt = paddleLeftCorner) OR (h_cnt = paddleRightCorner)OR
													(h_cnt = paddleLeftCorner-1) OR (h_cnt = paddleRightCorner+1)OR
													(h_cnt = paddleLeftCorner-2) OR (h_cnt = paddleRightCorner+2)OR
													(h_cnt = paddleLeftCorner-3) OR (h_cnt = paddleRightCorner+3))   THEN
						red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
						green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
						blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';				
			END IF;	
			IF (v_cnt >= 440 AND v_cnt <= 450) AND ((h_cnt = paddleLeftCorner+4) OR (h_cnt = paddleRightCorner-4)) THEN
				red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;	
		
	--/paddle drawing			

	--ball drawing

				IF (v_cnt = ballPositionV OR v_cnt = ballPositionV+11) AND (h_cnt >= ballPositionH-2 AND h_cnt <= ballPositionH+1) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
				END IF;
				
				IF (v_cnt = ballPositionV+1 OR v_cnt = ballPositionV+10) AND (h_cnt = ballPositionH-4 OR h_cnt = ballPositionH+3) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;	
				IF (v_cnt = ballPositionV+1 OR v_cnt = ballPositionV+10) AND (h_cnt = ballPositionH-3 OR h_cnt = ballPositionH+2) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;	
					
				IF (v_cnt = ballPositionV+2 OR v_cnt = ballPositionV+3 OR v_cnt = ballPositionV+9 OR v_cnt = ballPositionV+8) AND ((h_cnt = ballPositionH-5) OR (h_cnt = ballPositionH+4)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';					
				END IF;	
				
				IF (v_cnt >= ballPositionV+4 AND v_cnt <= ballPositionV+7) AND (h_cnt = ballPositionH-6 OR h_cnt = ballPositionH+5) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';					
				END IF;	
				--
				
				
				
				
				IF (v_cnt = ballPositionV+1 OR v_cnt = ballPositionV+10) AND (h_cnt >= ballPositionH-2 AND h_cnt <= ballPositionH+1) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
				
				IF (v_cnt = ballPositionV+2 OR v_cnt = ballPositionV+9) AND (h_cnt >= ballPositionH-4 AND h_cnt <= ballPositionH+3) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';	
				END IF;	
					
				IF (v_cnt = ballPositionV+3 OR v_cnt = ballPositionV+8) AND (h_cnt = ballPositionH-4 OR h_cnt = ballPositionH+3 OR h_cnt = ballPositionH-3 OR h_cnt = ballPositionH+2) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';	
				END IF;	
				
				IF (v_cnt >= ballPositionV+4 AND v_cnt <= ballPositionV+7) AND (h_cnt = ballPositionH-5 OR h_cnt = ballPositionH+4 OR h_cnt = ballPositionH-4 OR h_cnt = ballPositionH+3) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;	
				--
			
			
			
			
				IF (v_cnt = ballPositionV+3 OR v_cnt = ballPositionV+8) AND (h_cnt >= ballPositionH-2 AND h_cnt <= ballPositionH+1 ) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';				
				END IF;	
				
				IF (v_cnt = ballPositionV+4 OR v_cnt = ballPositionV+7) AND (h_cnt = ballPositionH-3 OR h_cnt = ballPositionH-2 OR h_cnt = ballPositionH+1 OR h_cnt = ballPositionH+2) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';				
				END IF;	
				IF (v_cnt = ballPositionV+5 OR v_cnt = ballPositionV+6) AND (h_cnt = ballPositionH-3 OR h_cnt = ballPositionH+2) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';					
				END IF;	
				--
			
				IF (v_cnt = ballPositionV+4 OR v_cnt = ballPositionV+7) AND (h_cnt = ballPositionH-1 OR h_cnt = ballPositionH) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';
				END IF;	
				IF (v_cnt = ballPositionV+5 OR v_cnt = ballPositionV+6) AND (h_cnt = ballPositionH-2 OR h_cnt = ballPositionH+1) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';	
				END IF;	
				--
			
			
				IF (v_cnt = ballPositionV+5 OR v_cnt = ballPositionV+6) AND (h_cnt = ballPositionH-1 OR h_cnt = ballPositionH) THEN
					red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
				END IF;			
				IF (v_cnt = ballPositionV+5) AND (h_cnt = ballPositionH) THEN
					red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;				
--/ball drawing				
		
				
		
	

		
		
-----------------------------------------------------------------------TESTI
		IF(startPauseGame='0' AND scrittaLampeggia='1' AND gameOver=0 AND youWin='0') THEN
		--PAUSE draw
			--P
				IF (((v_cnt = 300)) AND ((h_cnt >= Pause_p_Position) AND (h_cnt <= Pause_p_Position+3))) OR
					(((h_cnt = Pause_p_Position)) AND ((v_cnt >= 300) AND (v_cnt <= 310))) OR
					(((v_cnt >= 301) AND (v_cnt <=302 )) AND ((h_cnt = Pause_p_Position+4))) OR
					((v_cnt = 303) AND ((h_cnt = Pause_p_Position+3))) OR
					((v_cnt = 304) AND ((h_cnt >= Pause_p_Position+1)AND (h_cnt <= Pause_p_Position+2)))	
				  THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';
				END IF;			
			--/P
			--A
				IF (((v_cnt = 300 OR v_cnt = 305)) AND ((h_cnt >= Pause_a_Position+1) AND (h_cnt <= Pause_a_Position+3))) OR
				(((h_cnt = Pause_a_Position OR h_cnt = Pause_a_Position+4)) AND ((v_cnt >= 301) AND (v_cnt <= 310))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';				
				END IF;

			--/A
			--U
				IF (((v_cnt = 310)) AND ((h_cnt >= Pause_u_Position+1) AND (h_cnt <= Pause_u_Position+3))) OR
				(((h_cnt = Pause_u_Position OR h_cnt = Pause_u_Position+4)) AND ((v_cnt >= 300) AND (v_cnt <= 309))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/U		
			--S
				IF (((v_cnt = 300 OR v_cnt = 305 OR v_cnt = 310)) AND ((h_cnt >= Pause_s_Position+1) AND (h_cnt <= Pause_s_Position+3))) OR
					(((v_cnt >= 301 AND v_cnt<=304) OR v_cnt = 309) AND (h_cnt = Pause_s_Position)) OR
					(((v_cnt >= 306 AND v_cnt<=309) OR v_cnt = 301) AND (h_cnt = Pause_s_Position+4))THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/S
			--E
				IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= Pause_e_Position) AND (h_cnt <= Pause_e_Position+4))) OR
				(((v_cnt = 305)) AND ((h_cnt >= Pause_e_Position) AND (h_cnt <= Pause_e_Position+3))) OR
				(((h_cnt = Pause_e_Position)) AND ((v_cnt >= 300) AND (v_cnt <= 310))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/E

		--/PAUSE draw
		END IF;
		IF(gameOver=1 AND scrittaLampeggia='1') THEN
		-- GAME OVER draw
		--G
			IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= gameOver_g_Position+1) AND (h_cnt <= gameOver_g_Position+3))) OR
				(((h_cnt = gameOver_g_Position+4 )) AND ((v_cnt = 301) OR (v_cnt = 309) OR (v_cnt = 308) OR (v_cnt = 307))) OR
				(((h_cnt = gameOver_g_Position )) AND ((v_cnt >= 301) AND (v_cnt <= 309))) OR
				(((v_cnt = 307 )) AND ((h_cnt >= gameOver_g_Position+2) AND (h_cnt <= gameOver_g_Position+4))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/G
		--A
			IF (((v_cnt = 300 OR v_cnt = 305)) AND ((h_cnt >= gameOver_a_Position+1) AND (h_cnt <= gameOver_a_Position+3))) OR
			(((h_cnt = gameOver_a_Position OR h_cnt = gameOver_a_Position+4)) AND ((v_cnt >= 301) AND (v_cnt <= 310))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/A
		--M
			IF (((h_cnt = gameOver_m_Position OR h_cnt = gameOver_m_Position+4)) AND ((v_cnt >= 300) AND (v_cnt <= 310))) OR
			(((h_cnt = gameOver_m_Position+1 OR h_cnt = gameOver_m_Position+3) AND (v_cnt >= 301) AND (v_cnt <= 302)) )OR
			((h_cnt = gameOver_m_Position+2) AND (v_cnt >= 302) AND (v_cnt <= 303)) OR 
			((h_cnt = gameOver_m_Position+2) AND (v_cnt >= 302) AND (v_cnt <= 303)) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/M
		--E
			IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= gameOver_e_Position) AND (h_cnt <= gameOver_e_Position+4))) OR
			(((v_cnt = 305)) AND ((h_cnt >= gameOver_e_Position) AND (h_cnt <= gameOver_e_Position+3)))OR 
			(((h_cnt = gameOver_e_Position)) AND ((v_cnt >= 300) AND (v_cnt <= 310)))THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/E
		--0
			IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= gameOver_o_Position+1) AND (h_cnt <= gameOver_o_Position+3))) OR
				(((h_cnt = gameOver_o_Position OR h_cnt = gameOver_o_Position+4)) AND ((v_cnt >= 301) AND (v_cnt <= 309))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/0
		--V
			IF ((v_cnt >= 300 AND v_cnt <= 305) AND ((h_cnt = gameOver_v_Position) OR (h_cnt = gameOver_v_Position+4))) OR
				((v_cnt >= 305 AND v_cnt <= 307) AND ((h_cnt = gameOver_v_Position+1) OR (h_cnt = gameOver_v_Position+3))) OR 
				((v_cnt >= 308 AND v_cnt <= 310) AND ((h_cnt = gameOver_v_Position+2))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/V
		--E
			IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= gameOver_e2_Position) AND (h_cnt <= gameOver_e2_Position+4))) OR
			(((v_cnt = 305)) AND ((h_cnt >= gameOver_e2_Position) AND (h_cnt <= gameOver_e2_Position+3))) OR
			(((h_cnt = gameOver_e2_Position)) AND ((v_cnt >= 300) AND (v_cnt <= 310))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/E
		--R
			IF ((v_cnt >= 300 AND v_cnt<=310) AND ((h_cnt = gameOver_r_Position))) OR
				((v_cnt = 300 OR v_cnt = 305  OR v_cnt = 307 ) AND ((h_cnt = gameOver_r_Position+1))) OR
				((v_cnt = 300 OR v_cnt = 305  OR v_cnt = 308 ) AND ((h_cnt = gameOver_r_Position+2))) OR
				((v_cnt = 300 OR v_cnt = 304  OR v_cnt = 309 ) AND ((h_cnt = gameOver_r_Position+3))) OR
				((v_cnt = 301 OR v_cnt = 302 OR v_cnt = 303  OR v_cnt = 310 ) AND ((h_cnt = gameOver_r_Position+4))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/R

		--/GAME OVER draw
		END IF;
		-- You Win
			IF(youWin='1' AND scrittaLampeggia='1' ) THEN
			--Y
				IF (((v_cnt = 300)) AND ((h_cnt = youWin_y_Position) OR (h_cnt = youWin_y_Position+4))) OR
				(((v_cnt = 301)) AND ((h_cnt = youWin_y_Position+1) OR (h_cnt = youWin_y_Position+3)))OR 
				(((h_cnt = youWin_y_Position+2)) AND ((v_cnt >= 302) AND (v_cnt <= 310)))THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/Y			
		--0
			IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= youWin_o_Position+1) AND (h_cnt <= youWin_o_Position+3))) OR
				(((h_cnt = youWin_o_Position OR h_cnt = youWin_o_Position+4)) AND ((v_cnt >= 301) AND (v_cnt <= 309))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
			END IF;
		--/0			
			--U
				IF (((v_cnt = 310)) AND ((h_cnt >= youWin_u_Position+1) AND (h_cnt <= youWin_u_Position+3))) OR 
				(((h_cnt = youWin_u_Position OR h_cnt = youWin_u_Position+4)) AND ((v_cnt >= 300) AND (v_cnt <= 309))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/U		
			--W
				IF (((h_cnt = youWin_w_Position OR h_cnt = youWin_w_Position+4)) AND ((v_cnt >= 300) AND (v_cnt <= 309))) OR
					(((h_cnt = youWin_w_Position+1 OR h_cnt = youWin_w_Position+3)) AND ((v_cnt = 310)))OR 
					(((h_cnt = youWin_w_Position+2)) AND ((v_cnt >= 306) AND v_cnt<=309))THEN
						red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
						green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
						blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;

			--/W	
			--I
				IF (((v_cnt = 300 OR v_cnt = 310)) AND ((h_cnt >= youWin_i_Position+1) AND (h_cnt <= youWin_i_Position+3))) OR
					(((h_cnt = youWin_i_Position+2)) AND ((v_cnt >= 300) AND (v_cnt <= 310))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/I	
			--N
				IF (((h_cnt = youWin_n_Position OR h_cnt = youWin_n_Position+4)) AND ((v_cnt >=300) AND (v_cnt <= 310))) OR
					((h_cnt = youWin_n_Position+1) AND (v_cnt >= 301) AND (v_cnt <= 302)) OR
					(((h_cnt = youWin_n_Position+2) AND (v_cnt >= 303) AND (v_cnt <= 304))) OR
					((h_cnt = youWin_n_Position+3) AND (v_cnt >= 305) AND (v_cnt <= 306)) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
				END IF;
			--/N			
			--!
				IF (((v_cnt >= 300 AND v_cnt<308)) AND ((h_cnt = youWin_e_Position+3) )) OR
					(((v_cnt = 310)) AND ((h_cnt = youWin_e_Position+3) )) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
			--/!
							
			END IF;
		--You Win
		
		
		
			--ARKANOID arkanoid_
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= arkanoid_a_Position+1) AND (h_cnt <= arkanoid_a_Position+3))) OR
				(((h_cnt = arkanoid_a_Position OR h_cnt = arkanoid_a_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/A
			--R
				IF ((v_cnt >= 40 AND v_cnt<=50) AND ((h_cnt = arkanoid_r_Position))) OR
				((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 47 ) AND ((h_cnt = arkanoid_r_Position+1))) OR
				 ((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 48 ) AND ((h_cnt = arkanoid_r_Position+2))) OR
				 ((v_cnt = 40 OR v_cnt = 44  OR v_cnt = 49 ) AND ((h_cnt =arkanoid_r_Position+3))) OR
				((v_cnt = 41 OR v_cnt = 42 OR v_cnt = 43  OR v_cnt = 50 ) AND ((h_cnt = arkanoid_r_Position+4))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/R			
 			--K
				IF ((v_cnt >= 40 AND v_cnt<=50) AND ((h_cnt = arkanoid_k_Position))) OR
					(( v_cnt = 45  ) AND ((h_cnt = arkanoid_k_Position+1))) OR
					(( v_cnt = 44  OR v_cnt = 46 ) AND ((h_cnt = arkanoid_k_Position+1))) OR 
					(( v_cnt = 43  OR v_cnt = 47 ) AND ((h_cnt = arkanoid_k_Position+2))) OR
					(( v_cnt = 42  OR v_cnt = 48 ) AND ((h_cnt =arkanoid_k_Position+3))) OR
					((v_cnt = 40 OR v_cnt = 50  OR v_cnt = 41  OR v_cnt = 49) AND ((h_cnt = arkanoid_k_Position+4))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/K
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= arkanoid_a2_Position+1) AND (h_cnt <= arkanoid_a2_Position+3))) OR 
				(((h_cnt = arkanoid_a2_Position OR h_cnt = arkanoid_a2_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/A
			--N
				IF (((h_cnt = arkanoid_n_Position OR h_cnt = arkanoid_n_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR 
				((h_cnt = arkanoid_n_Position+1) AND (v_cnt >= 41) AND (v_cnt <= 42)) OR
				((h_cnt = arkanoid_n_Position+2) AND (v_cnt >= 43) AND (v_cnt <= 44)) OR 
				((h_cnt = arkanoid_n_Position+3) AND (v_cnt >= 45) AND (v_cnt <= 46)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/N	
			--0
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= arkanoid_o_Position+1) AND (h_cnt <= arkanoid_o_Position+3))) OR 
					(((h_cnt = arkanoid_o_Position OR h_cnt = arkanoid_o_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49)))THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/0
			--I
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= arkanoid_i_Position+1) AND (h_cnt <= arkanoid_i_Position+3))) OR
					(((h_cnt = arkanoid_i_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/I	
			--D
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= arkanoid_d_Position) AND (h_cnt <= arkanoid_d_Position+3))) OR 
					(((h_cnt = arkanoid_d_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
					(((h_cnt = arkanoid_d_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49)))THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
		
			--/D
			--/ARKANOID
			--onAlterade1
			--0
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= onAlterade1_o_Position+1) AND (h_cnt <= onAlterade1_o_Position+3))) OR
					(((h_cnt = onAlterade1_o_Position OR h_cnt = onAlterade1_o_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/0
			--N
				IF (((h_cnt = onAlterade1_n_Position OR h_cnt = onAlterade1_n_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR 
				((h_cnt = onAlterade1_n_Position+1) AND (v_cnt >= 41) AND (v_cnt <= 42)) OR
				((h_cnt = onAlterade1_n_Position+2) AND (v_cnt >= 43) AND (v_cnt <= 44)) OR 
				((h_cnt = onAlterade1_n_Position+3) AND (v_cnt >= 45) AND (v_cnt <= 46)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;		
			--/N						
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= onAlterade1_a_Position+1) AND (h_cnt <= onAlterade1_a_Position+3))) OR 
				(((h_cnt = onAlterade1_a_Position OR h_cnt = onAlterade1_a_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/A	
			--L
				IF (((v_cnt = 50)) AND ((h_cnt >= onAlterade1_l_Position) AND (h_cnt <= onAlterade1_l_Position+4))) OR 
				(((h_cnt = onAlterade1_l_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/L
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= onAlterade1_t_Position) AND (h_cnt <= onAlterade1_t_Position+4))) OR
				(((h_cnt = onAlterade1_t_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/T
			--E
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= onAlterade1_e_Position) AND (h_cnt <= onAlterade1_e_Position+4))) OR 
					(((v_cnt = 45)) AND ((h_cnt >= onAlterade1_e_Position) AND (h_cnt <= onAlterade1_e_Position+3))) OR
					(((h_cnt = onAlterade1_e_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/E
			--R
				IF ((v_cnt >= 40 AND v_cnt<=50) AND ((h_cnt = onAlterade1_r_Position))) OR
				((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 47 ) AND ((h_cnt = onAlterade1_r_Position+1))) OR
				 ((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 48 ) AND ((h_cnt = onAlterade1_r_Position+2))) OR
				 ((v_cnt = 40 OR v_cnt = 44  OR v_cnt = 49 ) AND ((h_cnt =onAlterade1_r_Position+3))) OR
				((v_cnt = 41 OR v_cnt = 42 OR v_cnt = 43  OR v_cnt = 50 ) AND ((h_cnt = onAlterade1_r_Position+4))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/R
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= onAlterade1_a2_Position+1) AND (h_cnt <= onAlterade1_a2_Position+3))) OR 
				(((h_cnt = onAlterade1_a2_Position OR h_cnt = onAlterade1_a2_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/A
			--/A	
			--D
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= onAlterade1_d_Position) AND (h_cnt <= onAlterade1_d_Position+3))) OR 
					(((h_cnt = onAlterade1_d_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
					(((h_cnt = onAlterade1_d_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49)))THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;			
			--/D

			--E
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= onAlterade1_e2_Position) AND (h_cnt <= onAlterade1_e2_Position+4))) OR 
					(((v_cnt = 45)) AND ((h_cnt >= onAlterade1_e2_Position) AND (h_cnt <= onAlterade1_e2_Position+3))) OR
					(((h_cnt = onAlterade1_e2_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/E
			--1
				IF (((v_cnt = 41)) AND ((h_cnt = onAlterade1_1_Position+1) )) OR
				(((v_cnt = 42)) AND ((h_cnt = onAlterade1_1_Position) )) OR 
				(((v_cnt = 50)) AND ((h_cnt >= onAlterade1_1_Position+1) AND (h_cnt <= onAlterade1_1_Position+3))) OR
				(((h_cnt = onAlterade1_1_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50)))THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--1					
			
			
			--/onAlterade1

--GAZZIN MATTEO
			--G
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_g_Position+1) AND (h_cnt <= gazzinMatteo_g_Position+3))) OR
				(((h_cnt = gazzinMatteo_g_Position+4 )) AND ((v_cnt = 41) OR (v_cnt = 49) OR (v_cnt = 48) OR (v_cnt = 47))) OR
				(((h_cnt = gazzinMatteo_g_Position )) AND ((v_cnt >= 41) AND (v_cnt <= 49))) OR
				(((v_cnt = 47 )) AND ((h_cnt >= gazzinMatteo_g_Position+2) AND (h_cnt <= gazzinMatteo_g_Position+4)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/G	
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= gazzinMatteo_a_Position+1) AND (h_cnt <= gazzinMatteo_a_Position+3))) OR
				(((h_cnt = gazzinMatteo_a_Position OR h_cnt = gazzinMatteo_a_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
			--/A			
			--Z
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_z_Position) AND (h_cnt <= gazzinMatteo_z_Position+4))) OR
				(((h_cnt = gazzinMatteo_z_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 43))) OR
				(((h_cnt = gazzinMatteo_z_Position+3)) AND ((v_cnt = 44))) OR
				(((h_cnt = gazzinMatteo_z_Position+2)) AND ((v_cnt = 45))) OR 
				(((h_cnt = gazzinMatteo_z_Position+1)) AND ((v_cnt = 46))) OR
				(((h_cnt = gazzinMatteo_z_Position)) AND ((v_cnt >= 47) AND (v_cnt <= 49)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/Z	
			--Z
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_z2_Position) AND (h_cnt <= gazzinMatteo_z2_Position+4))) OR
				(((h_cnt = gazzinMatteo_z2_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 43))) OR
				(((h_cnt = gazzinMatteo_z2_Position+3)) AND ((v_cnt = 44))) OR
				(((h_cnt = gazzinMatteo_z2_Position+2)) AND ((v_cnt = 45))) OR 
				(((h_cnt = gazzinMatteo_z2_Position+1)) AND ((v_cnt = 46))) OR
				(((h_cnt = gazzinMatteo_z2_Position)) AND ((v_cnt >= 47) AND (v_cnt <= 49)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/Z	
			--I
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_i_Position+1) AND (h_cnt <= gazzinMatteo_i_Position+3))) OR
				(((h_cnt = gazzinMatteo_i_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/I	
			--N
				IF (((h_cnt = gazzinMatteo_n_Position OR h_cnt = gazzinMatteo_n_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
				(((h_cnt = gazzinMatteo_n_Position+1) AND (v_cnt >= 41) AND (v_cnt <= 42))) OR 
				(((h_cnt = gazzinMatteo_n_Position+2) AND (v_cnt >= 43) AND (v_cnt <= 44))) OR
				(((h_cnt = gazzinMatteo_n_Position+3) AND (v_cnt >= 45) AND (v_cnt <= 46)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/N	
			


			--M
				IF (((h_cnt = gazzinMatteo_m_Position OR h_cnt = gazzinMatteo_m_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
				((h_cnt = gazzinMatteo_m_Position+1 OR h_cnt = gazzinMatteo_m_Position+3) AND (v_cnt >= 41) AND (v_cnt <= 42)) OR
				 (((h_cnt = gazzinMatteo_m_Position+2) AND (v_cnt >= 42) AND (v_cnt <= 43)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/M	
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= gazzinMatteo_a2_Position+1) AND (h_cnt <= gazzinMatteo_a2_Position+3))) OR
				(((h_cnt = gazzinMatteo_a2_Position OR h_cnt = gazzinMatteo_a2_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50)))  THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
			--/A
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= gazzinMatteo_t_Position) AND (h_cnt <= gazzinMatteo_t_Position+4))) OR
				(((h_cnt = gazzinMatteo_t_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/T
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= gazzinMatteo_t2_Position) AND (h_cnt <= gazzinMatteo_t2_Position+4))) OR
					(((h_cnt = gazzinMatteo_t2_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/T
			--E
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_e_Position) AND (h_cnt <= gazzinMatteo_e_Position+4))) OR 
				(((v_cnt = 45)) AND ((h_cnt >= gazzinMatteo_e_Position) AND (h_cnt <= gazzinMatteo_e_Position+3))) OR
				(((h_cnt = gazzinMatteo_e_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/E			
			--0
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= gazzinMatteo_o_Position+1) AND (h_cnt <= gazzinMatteo_o_Position+3))) OR
				(((h_cnt = gazzinMatteo_o_Position OR h_cnt = gazzinMatteo_o_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;				
			--/0		
			--/
			-- UNITS
			--U
				IF (((v_cnt = 50)) AND ((h_cnt >= units_u_Position+1) AND (h_cnt <= units_u_Position+3))) OR
				(((h_cnt = units_u_Position OR h_cnt = units_u_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 49))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/U	
			--N
				IF (((h_cnt = units_n_Position OR h_cnt = units_n_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
				(((h_cnt = units_n_Position+1) AND (v_cnt >= 41) AND (v_cnt <= 42))) OR 
				(((h_cnt = units_n_Position+2) AND (v_cnt >= 43) AND (v_cnt <= 44))) OR
				(((h_cnt = units_n_Position+3) AND (v_cnt >= 45) AND (v_cnt <= 46)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/N		
			--I
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= units_i_Position+1) AND (h_cnt <= units_i_Position+3))) OR
				(((h_cnt = units_i_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/I
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= units_t_Position) AND (h_cnt <= units_t_Position+4))) OR
					(((h_cnt = units_t_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/T
			--S
				IF (((v_cnt = 40 OR v_cnt = 45 OR v_cnt = 50)) AND ((h_cnt >= units_s_Position+1) AND (h_cnt <= units_s_Position+3))) OR
				(((v_cnt >= 41 AND v_cnt<=44) OR v_cnt = 49) AND (h_cnt = units_s_Position)) OR
				(((v_cnt >= 46 AND v_cnt<=49) OR v_cnt = 41) AND (h_cnt = units_s_Position+4)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/S
			-- /UNITS
			
			--ELETTRONICA 2 FPGA
			--E
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_e_Position) AND (h_cnt <= elettronica2fpga_e_Position+4))) OR
				(((v_cnt = 45)) AND ((h_cnt >= elettronica2fpga_e_Position) AND (h_cnt <= elettronica2fpga_e_Position+3))) OR
				(((h_cnt = elettronica2fpga_e_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/E
			--L
				IF (((v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_l_Position) AND (h_cnt <= elettronica2fpga_l_Position+4))) OR
				(((h_cnt = elettronica2fpga_l_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/L
			--E
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_e2_Position) AND (h_cnt <= elettronica2fpga_e2_Position+4))) OR
				(((v_cnt = 45)) AND ((h_cnt >= elettronica2fpga_e2_Position) AND (h_cnt <= elettronica2fpga_e2_Position+3))) OR
				(((h_cnt = elettronica2fpga_e2_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
			--/E
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= elettronica2fpga_t_Position) AND (h_cnt <= elettronica2fpga_t_Position+4))) OR
					(((h_cnt = elettronica2fpga_t_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/T
			--T
				IF (((v_cnt = 40)) AND ((h_cnt >= elettronica2fpga_t2_Position) AND (h_cnt <= elettronica2fpga_t2_Position+4))) OR
					(((h_cnt = elettronica2fpga_t2_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/T
			--R
				IF ((v_cnt >= 40 AND v_cnt<=50) AND ((h_cnt = elettronica2fpga_r_Position))) OR
				((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 47 ) AND ((h_cnt = elettronica2fpga_r_Position+1))) OR
				 ((v_cnt = 40 OR v_cnt = 45  OR v_cnt = 48 ) AND ((h_cnt = elettronica2fpga_r_Position+2))) OR
				 ((v_cnt = 40 OR v_cnt = 44  OR v_cnt = 49 ) AND ((h_cnt =elettronica2fpga_r_Position+3))) OR
				((v_cnt = 41 OR v_cnt = 42 OR v_cnt = 43  OR v_cnt = 50 ) AND ((h_cnt = elettronica2fpga_r_Position+4))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/R
			--0
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_o_Position+1) AND (h_cnt <= elettronica2fpga_o_Position+3))) OR
				(((h_cnt = elettronica2fpga_o_Position OR h_cnt = elettronica2fpga_o_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 49))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;				
			--/0
			--N
				IF (((h_cnt = elettronica2fpga_n_Position OR h_cnt = elettronica2fpga_n_Position+4)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
				(((h_cnt = elettronica2fpga_n_Position+1) AND (v_cnt >= 41) AND (v_cnt <= 42))) OR 
				(((h_cnt = elettronica2fpga_n_Position+2) AND (v_cnt >= 43) AND (v_cnt <= 44))) OR
				(((h_cnt = elettronica2fpga_n_Position+3) AND (v_cnt >= 45) AND (v_cnt <= 46)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/N		
			--I
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_i_Position+1) AND (h_cnt <= elettronica2fpga_i_Position+3))) OR
				(((h_cnt = elettronica2fpga_i_Position+2)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/I
			--C
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_c_Position+1) AND (h_cnt <= elettronica2fpga_c_Position+3))) OR
				(((h_cnt = elettronica2fpga_c_Position+4 )) AND ((v_cnt = 41) OR (v_cnt = 49) )) OR
				(((h_cnt = elettronica2fpga_c_Position )) AND ((v_cnt >= 41) AND (v_cnt <= 49)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/C
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= elettronica2fpga_a_Position+1) AND (h_cnt <= elettronica2fpga_a_Position+3))) OR
				(((h_cnt = elettronica2fpga_a_Position OR h_cnt = elettronica2fpga_a_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/A
			
			--2
				IF ((v_cnt = 40 ) AND (h_cnt >= elettronica2fpga_2_Position+1 AND h_cnt <= elettronica2fpga_2_Position+3)) OR
				((v_cnt = 41) AND (h_cnt = elettronica2fpga_2_Position OR h_cnt = elettronica2fpga_2_Position+4)) OR
				((v_cnt = 42) AND (h_cnt = elettronica2fpga_2_Position+4)) OR
				((v_cnt = 43) AND (h_cnt = elettronica2fpga_2_Position+3)) OR
				((v_cnt = 44) AND (h_cnt = elettronica2fpga_2_Position+2)) OR
				((v_cnt = 45) AND (h_cnt = elettronica2fpga_2_Position+1)) OR
				(((v_cnt >= 46 AND v_cnt<=49)) AND (h_cnt = elettronica2fpga_2_Position)) OR
				((v_cnt = 50 ) AND ((h_cnt >= elettronica2fpga_2_Position) AND (h_cnt <= elettronica2fpga_2_Position+4)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/2
			--F
				IF (((v_cnt = 40)) AND ((h_cnt >= elettronica2fpga_f_Position) AND (h_cnt <= elettronica2fpga_f_Position+4))) OR
				(((v_cnt = 45)) AND ((h_cnt >= elettronica2fpga_f_Position) AND (h_cnt <= elettronica2fpga_f_Position+3))) OR
				(((h_cnt = elettronica2fpga_f_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/F	
			--P
				IF (((v_cnt = 40)) AND ((h_cnt >= elettronica2fpga_p_Position) AND (h_cnt <= elettronica2fpga_p_Position+3))) OR
				(((h_cnt = elettronica2fpga_p_Position)) AND ((v_cnt >= 40) AND (v_cnt <= 50))) OR
				(((v_cnt >= 41) AND (v_cnt <=42 )) AND ((h_cnt = elettronica2fpga_p_Position+4))) OR
				(((v_cnt = 43) AND ((h_cnt = elettronica2fpga_p_Position+3)))) OR
				(((v_cnt = 44) AND ((h_cnt >= elettronica2fpga_p_Position+1)AND (h_cnt <= elettronica2fpga_p_Position+2))))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
			--/P				
			--G
				IF (((v_cnt = 40 OR v_cnt = 50)) AND ((h_cnt >= elettronica2fpga_g_Position+1) AND (h_cnt <= elettronica2fpga_g_Position+3))) OR
				(((h_cnt = elettronica2fpga_g_Position+4 )) AND ((v_cnt = 41) OR (v_cnt = 49) OR (v_cnt = 48) OR (v_cnt = 47))) OR
				(((h_cnt = elettronica2fpga_g_Position )) AND ((v_cnt >= 41) AND (v_cnt <= 49))) OR
				(((v_cnt = 47 )) AND ((h_cnt >= elettronica2fpga_g_Position+2) AND (h_cnt <= elettronica2fpga_g_Position+4)))THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
			--/G	
			--A
				IF (((v_cnt = 40 OR v_cnt = 45)) AND ((h_cnt >= elettronica2fpga_a2_Position+1) AND (h_cnt <= elettronica2fpga_a2_Position+3))) OR
				(((h_cnt = elettronica2fpga_a2_Position OR h_cnt = elettronica2fpga_a2_Position+4)) AND ((v_cnt >= 41) AND (v_cnt <= 50))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
			--/A	
			

			--/ELETTRONICA 2 FPGA

-------------------------------------------------------------------------FINE TESTI		

--acqua		

				

			FOR i IN 0 to 32 LOOP
				IF (
					 (v_cnt = water_surface) AND (h_cnt >= leftBorder+9+waterPeriod and h_cnt <= leftBorder+12+waterPeriod)
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+1) AND ((h_cnt >= leftBorder+7+waterPeriod and h_cnt <= leftBorder+8+waterPeriod) OR (h_cnt >= leftBorder+13+waterPeriod and h_cnt <= leftBorder+14+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+2) AND ((h_cnt = leftBorder+6+waterPeriod OR h_cnt = leftBorder+15+waterPeriod) )
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+3) AND ((h_cnt >= leftBorder+4+waterPeriod and h_cnt <= leftBorder+5+waterPeriod) OR (h_cnt >= leftBorder+16+waterPeriod and h_cnt <= leftBorder+17+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;			
				IF (
					 (v_cnt = water_surface+4) AND ((h_cnt >= leftBorder+waterPeriod and h_cnt <= leftBorder+3+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				
				
				IF (
					 (v_cnt = water_surface+1) AND (h_cnt >= leftBorder+9+waterPeriod and h_cnt <= leftBorder+12+waterPeriod)
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+2) AND ((h_cnt >= leftBorder+7+waterPeriod and h_cnt <= leftBorder+8+waterPeriod) OR (h_cnt >= leftBorder+13+waterPeriod and h_cnt <= leftBorder+14+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';				
				END IF;
				IF (
					 (v_cnt = water_surface+3) AND ((h_cnt = leftBorder+6+waterPeriod OR h_cnt = leftBorder+15+waterPeriod) )
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+4) AND ((h_cnt >= leftBorder+4+waterPeriod and h_cnt <= leftBorder+5+waterPeriod) OR (h_cnt >= leftBorder+16+waterPeriod and h_cnt <= leftBorder+17+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;			
				IF (
					 (v_cnt = water_surface+5) AND ((h_cnt >= leftBorder+waterPeriod and h_cnt <= leftBorder+3+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';					
				END IF;
				
					 
				IF (
					 (v_cnt = water_surface+2) AND (h_cnt >= leftBorder+9+waterPeriod and h_cnt <= leftBorder+12+waterPeriod)
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+3) AND ((h_cnt >= leftBorder+7+waterPeriod and h_cnt <= leftBorder+8+waterPeriod) OR (h_cnt >= leftBorder+13+waterPeriod and h_cnt <= leftBorder+14+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';				
				END IF;
				IF (
					 (v_cnt = water_surface+4) AND ((h_cnt = leftBorder+6+waterPeriod OR h_cnt = leftBorder+15+waterPeriod) )
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';					
				END IF;
				IF (
					 (v_cnt = water_surface+5) AND ((h_cnt >= leftBorder+4+waterPeriod and h_cnt <= leftBorder+5+waterPeriod) OR (h_cnt >= leftBorder+16+waterPeriod and h_cnt <= leftBorder+17+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';				
				END IF;			
				IF (
					 (v_cnt = water_surface+6) AND ((h_cnt >= leftBorder+waterPeriod and h_cnt <= leftBorder+3+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';						
				END IF;
				
				
				IF (
					 (v_cnt = water_surface+3) AND (h_cnt >= leftBorder+9+waterPeriod and h_cnt <= leftBorder+12+waterPeriod)
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF (
					 (v_cnt = water_surface+4) AND ((h_cnt >= leftBorder+7+waterPeriod and h_cnt <= leftBorder+8+waterPeriod) OR (h_cnt >= leftBorder+13+waterPeriod and h_cnt <= leftBorder+14+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF (
					 (v_cnt = water_surface+5) AND ((h_cnt = leftBorder+6+waterPeriod OR h_cnt = leftBorder+15+waterPeriod) )
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';					
				END IF;
				IF (
					 (v_cnt = water_surface+6) AND ((h_cnt >= leftBorder+4+waterPeriod and h_cnt <= leftBorder+5+waterPeriod) OR (h_cnt >= leftBorder+16+waterPeriod and h_cnt <= leftBorder+17+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;			
				IF (
					 (v_cnt = water_surface+7) AND ((h_cnt >= leftBorder+waterPeriod and h_cnt <= leftBorder+3+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';						
				END IF;			
					
				IF (
					 (v_cnt >= water_surface+4) AND (h_cnt >= leftBorder+9+waterPeriod and h_cnt <= leftBorder+12+waterPeriod)
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';				
				END IF;
				IF (
					 (v_cnt >= water_surface+5) AND ((h_cnt >= leftBorder+7+waterPeriod and h_cnt <= leftBorder+8+waterPeriod) OR (h_cnt >= leftBorder+13+waterPeriod and h_cnt <= leftBorder+14+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';				
				END IF;
				IF (
					 (v_cnt >= water_surface+6) AND ((h_cnt = leftBorder+6+waterPeriod OR h_cnt = leftBorder+15+waterPeriod) )
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';						
				END IF;
				IF (
					 (v_cnt >= water_surface+7) AND ((h_cnt >= leftBorder+4+waterPeriod and h_cnt <= leftBorder+5+waterPeriod) OR (h_cnt >= leftBorder+16+waterPeriod and h_cnt <= leftBorder+17+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';					
				END IF;			
				IF (
					 (v_cnt >= water_surface+8) AND ((h_cnt >= leftBorder+waterPeriod and h_cnt <= leftBorder+3+waterPeriod))
				) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';							
				END IF;						
				
			
				
			waterPeriod:=waterPeriod+18;
			END LOOP;
			waterPeriod:=0;
--/acqua





---BORDO SCHERMO

				IF ((h_cnt = leftBorder-10)  AND ((v_cnt >= upBorder-4) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = leftBorder-9)  AND ((v_cnt >= upBorder-6) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = leftBorder-8)  AND ((v_cnt >= upBorder-7) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = leftBorder-7)  AND ((v_cnt >= upBorder-5) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = leftBorder-6)  AND ((v_cnt >= upBorder-5) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = leftBorder-5)  AND ((v_cnt >= upBorder-4) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = leftBorder-4)  AND ((v_cnt >= upBorder-3) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = leftBorder-3)  AND ((v_cnt >= upBorder-2) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = leftBorder-2)  AND ((v_cnt >= upBorder-1) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
				IF ((h_cnt = leftBorder-1)  AND ((v_cnt >= upBorder) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';		
				END IF;
				IF ((h_cnt = leftBorder)  AND ((v_cnt >= upBorder) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				
				
				IF ((h_cnt = RightBorder)  AND ((v_cnt >= upBorder-4) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = RightBorder-1)  AND ((v_cnt >= upBorder-6) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = RightBorder-2)  AND ((v_cnt >= upBorder-7) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;--
				IF ((h_cnt = RightBorder-3)  AND ((v_cnt >= upBorder-5) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = RightBorder-4)  AND ((v_cnt >= upBorder-6) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = RightBorder-5)  AND ((v_cnt >= upBorder-5) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = RightBorder-6)  AND ((v_cnt >= upBorder-4) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
				IF ((h_cnt = RightBorder-7)  AND ((v_cnt >= upBorder-3) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((h_cnt = RightBorder-8)  AND ((v_cnt >= upBorder-2) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
				IF ((h_cnt = RightBorder-9)  AND ((v_cnt >= upBorder-1) AND (v_cnt <= 480))) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';		
				END IF;
				IF ((h_cnt = RightBorder-10)  AND ((v_cnt >= upBorder) AND (v_cnt <= 480))) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
								
				IF ((v_cnt = upBorder-10 )) AND ((h_cnt >= leftBorder-4) AND (h_cnt <= rightBorder-6)) THEN
					red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((v_cnt = upBorder-9 )) AND ((h_cnt >= leftBorder-6) AND (h_cnt <= rightBorder-4)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((v_cnt = upBorder-8 )) AND ((h_cnt >= leftBorder-7) AND (h_cnt <= rightBorder-3)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
				IF ((v_cnt = upBorder-7 )) AND ((h_cnt >= leftBorder-8) AND (h_cnt <= rightBorder-3)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((v_cnt = upBorder-6 )) AND ((h_cnt >= leftBorder-7) AND (h_cnt <= rightBorder-3)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;
				IF ((v_cnt = upBorder-5 )) AND ((h_cnt >= leftBorder-5) AND (h_cnt <= rightBorder-6)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';			
				END IF;
				IF ((v_cnt = upBorder-4 )) AND ((h_cnt >= leftBorder-4) AND (h_cnt <= rightBorder-7)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';			
				END IF;
				IF ((v_cnt = upBorder-3 )) AND ((h_cnt >= leftBorder-3) AND (h_cnt <= rightBorder-8)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';			
				END IF;
				IF ((v_cnt = upBorder-2 )) AND ((h_cnt >= leftBorder-2) AND (h_cnt <= rightBorder-9)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '1';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '1';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '1';		
				END IF;
				IF ((v_cnt = upBorder-1 )) AND ((h_cnt >= leftBorder-1) AND (h_cnt <= rightBorder-10)) THEN
					red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
					green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
					blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';		
				END IF;
				IF ((v_cnt = upBorder )) AND ((h_cnt >= leftBorder) AND (h_cnt <= rightBorder-10)) THEN
					red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '1';		
					green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '1';
					blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '1';			
				END IF;

---/BORDO SCHERMO





		IF (obstacles(0) = '1') THEN
			IF ((v_cnt >= obstacle_n(0)+1) AND (v_cnt <= obstacle_s(0)-1) AND (h_cnt >= obstacle_w(0)+1) AND (h_cnt <= obstacle_e(0)-1))  THEN
				red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(1) = '1') THEN
			IF ((v_cnt >= obstacle_n(1)+1) AND (v_cnt <= obstacle_s(1)-1) AND (h_cnt >= obstacle_w(1)+1) AND (h_cnt <= obstacle_e(1)-1))  THEN
				red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '1';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(2) = '1') THEN
			IF ((v_cnt >= obstacle_n(2)+1) AND (v_cnt <= obstacle_s(2)-1) AND (h_cnt >= obstacle_w(2)+1) AND (h_cnt <= obstacle_e(2)-1))  THEN
				red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '1';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(3) = '1') THEN
			IF ((v_cnt >= obstacle_n(3)+1) AND (v_cnt <= obstacle_s(3)-1) AND (h_cnt >= obstacle_w(3)+1) AND (h_cnt <= obstacle_e(3)-1))  THEN
				red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(4) = '1') THEN
			IF ((v_cnt >= obstacle_n(4)+1) AND (v_cnt <= obstacle_s(4)-1) AND (h_cnt >= obstacle_w(4)+1) AND (h_cnt <= obstacle_e(4)-1))  THEN
				red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(5) = '1') THEN
			IF ((v_cnt >= obstacle_n(5)+1) AND (v_cnt <= obstacle_s(5)-1) AND (h_cnt >= obstacle_w(5)+1) AND (h_cnt <= obstacle_e(5)-1))  THEN
				red3_signal <= '1';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';	
			END IF;
		END IF;		
		IF (obstacles(6) = '1') THEN
			IF ((v_cnt >= obstacle_n(6)+1) AND (v_cnt <= obstacle_s(6)-1) AND (h_cnt >= obstacle_w(6)+1) AND (h_cnt <= obstacle_e(6)-1))  THEN
				red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '1';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '0';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;		
		IF (obstacles(7) = '1') THEN
			IF ((v_cnt >= obstacle_n(7)+1) AND (v_cnt <= obstacle_s(7)-1) AND (h_cnt >= obstacle_w(7)+1) AND (h_cnt <= obstacle_e(7)-1))  THEN
				red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(8) = '1') THEN
			IF ((v_cnt >= obstacle_n(8)+1) AND (v_cnt <= obstacle_s(8)-1) AND (h_cnt >= obstacle_w(8)+1) AND (h_cnt <= obstacle_e(8)-1))  THEN
				red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '1';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(9) = '1') THEN
			IF ((v_cnt >= obstacle_n(9)+1) AND (v_cnt <= obstacle_s(9)-1) AND (h_cnt >= obstacle_w(9)+1) AND (h_cnt <= obstacle_e(9)-1))  THEN
				red3_signal <= '1';		red2_signal <= '0';		red1_signal <= '0';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '0';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '1';	blue1_signal <= '0';	blue0_signal <= '0';	
			END IF;
		END IF;
		IF (obstacles(10) = '1') THEN
			IF ((v_cnt >= obstacle_n(10)+1) AND (v_cnt <= obstacle_s(10)-1) AND (h_cnt >= obstacle_w(10)+1) AND (h_cnt <= obstacle_e(10)-1))  THEN
				red3_signal <= '0';		red2_signal <= '0';		red1_signal <= '1';		red0_signal <= '0';		
				green3_signal <= '1';	green2_signal <= '1';	green1_signal <= '0';	green0_signal <= '0';
				blue3_signal <= '1';	blue2_signal <= '0';	blue1_signal <= '1';	blue0_signal <= '0';	
			END IF;
		END IF;

--/obstacles drawing		
		
--Fixed Obstacles

			IF ((v_cnt >=195) AND (v_cnt <= 204) AND (h_cnt >= 61) AND (h_cnt <= 110)) OR 
				((v_cnt >=185) AND (v_cnt <= 194) AND (h_cnt >= 211) AND (h_cnt <= 260)) OR
				((v_cnt >=195) AND (v_cnt <= 204) AND (h_cnt >= 306) AND (h_cnt <= 355)) OR
				((v_cnt >=185) AND (v_cnt <= 194) AND (h_cnt >= 401) AND (h_cnt <= 450)) OR
				((v_cnt >=195) AND (v_cnt <= 204) AND (h_cnt >= 551) AND (h_cnt <= 600)) THEN
				red3_signal <= '0';		red2_signal <= '1';		red1_signal <= '1';		red0_signal <= '0';		
				green3_signal <= '0';	green2_signal <= '1';	green1_signal <= '1';	green0_signal <= '0';
				blue3_signal <= '0';	blue2_signal <= '1';	blue1_signal <= '1';	blue0_signal <= '0';	
			END IF;

--/Fixed Obstacles		
		
			--Generate Horizontal Sync
		IF (h_cnt <= 755) AND (h_cnt >= 659) THEN
			h_sync <= '0';
		ELSE
			h_sync <= '1';
		END IF;
		
		--Vertical Sync

			--Reset Vertical Counter
		IF (v_cnt >= 524) AND (h_cnt >= 699) THEN
			v_cnt <= "0000000000";
		ELSIF (h_cnt = 699) THEN
			v_cnt <= v_cnt + 1;
		END IF;
		
			--Generate Vertical Sync
		IF (v_cnt <= 494) AND (v_cnt >= 493) THEN
			v_sync <= '0';	
			
		ELSE
			v_sync <= '1';
		END IF;
		
			--Generate Horizontal Data
		IF (h_cnt <= 639) THEN
			horizontal_en <= '1';
			--column <= h_cnt;
		ELSE
			horizontal_en <= '0';
		END IF;
		
			--Generate Vertical Data
		IF (v_cnt <= 479) THEN
			vertical_en <= '1';
			--row <= v_cnt;
		ELSE
			vertical_en <= '0';
		END IF;
		
	--Assign Physical Signals To VGA
	red0		<= red0_signal AND video_en;
	green0   <= green0_signal AND video_en;
	blue0	<= blue0_signal AND video_en;
	red1		<= red1_signal AND video_en;
	green1   <= green1_signal AND video_en;
	blue1	<= blue1_signal AND video_en;
	red2		<= red2_signal AND video_en;
	green2   <= green2_signal AND video_en;
	blue2	<= blue2_signal AND video_en;
	red3		<= red3_signal AND video_en;
	green3   <= green3_signal AND video_en;
	blue3	<= blue3_signal AND video_en;
	hsync	<= h_sync;
	vsync	<= v_sync;
	
	--END IF;--StartGame	
END PROCESS;
END behavior;