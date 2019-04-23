

#define NULL (void*) 0

int Bit_Test(unsigned int val, int bit) {

	unsigned int test_val = 0x00000001;

	test_val = (test_val << bit);
	if ((val & test_val) == 0) {
		return 0;
	} else {
		return 1;
	}

}

void Bit_Set(unsigned int* val, int bit) {

	unsigned int test_val = 0x00000001;

	test_val = (test_val << bit);
	*val = (*val | test_val);

}

void Bit_Clear(unsigned int* val, int bit) {

	unsigned int test_val = 0x00000001;

	test_val = (test_val << bit);
	*val = (*val & ~(test_val));
	
}

void Bit_Clear_Range(unsigned int* val, int start, int end){

	int i = 0;
	for(i = start; i <= end; i++){
		Bit_Clear(val, i);
	}

}

unsigned int* move_to(unsigned int x, unsigned int y){
	unsigned int result = 0xffff0000;
	unsigned int temp = 0;
	if(80 <= x) x = 79;
	if(30 <= y) y = 29;
	temp = (y << 7);
	result = result + temp + x;
	return (unsigned int *) result;
}

int mult(int a, int b){
	int result = 0;
	int i = 0;
	for(i = 0; i < b; i++){
		result += a;
	}
	return result;
}

int p_div_mod(int a, int b, int* mod){
	int result = 0;
	int tmp = a;
	if(b != 1 && b != -1){
		if(tmp > 0){
			while(tmp >= b){
				result++;
				tmp = tmp - b;
			}
		} else {
			while(tmp <= -b){
				result++;
				tmp = tmp + b;
			}
		}
	} else {
		if(b == 1) result = tmp;
		else result = -tmp;
	}
	if(mod != NULL){
		*mod = tmp;
	}
	return result;
}

void start (unsigned int* movexy, unsigned int* movex, unsigned int* movey) {

//Herzlich Willkommen! (0:30)
movexy = (unsigned int*) 0xffff001E;
*movexy = 0x20;
*movex = 0x48;
*movex = 0x65;
*movex = 0x72;
*movex = 0x7a;
*movex = 0x6c;
*movex = 0x69;
*movex = 0x63;
*movex = 0x68;
*movex = 0x00;
*movex = 0x57;
*movex = 0x69;
*movex = 0x6c;
*movex = 0x6c;
*movex = 0x6b;
*movex = 0x6f;
*movex = 0x6d;
*movex = 0x6d;
*movex = 0x65;
*movex = 0x6e;
*movex = 0x21;

//Waehlen Sie: (3:15)
movexy = (unsigned int *) 0xffff018f;
*movexy = 0x20;
*movex = 0x57;
*movex = 0x61;
*movex = 0x65;
*movex = 0x68;
*movex = 0x6c;
*movex = 0x65;
*movex = 0x6E;
*movex = 0x00;
*movex = 0x53;
*movex = 0x69;
*movex = 0x65;
*movex = 0x3a;


//- Show (4:15)
movexy = (unsigned int *) 0xffff020f;
*movexy = 0x20;
*movex = 0x2d;
*movex = 0x20;
*movex = 0x53;
*movex = 0x68;
*movex = 0x6f;
*movex = 0x77;
//-Taschenrechner (5:15)
movexy = (unsigned int *) 0xffff028f;
*movexy = 0x20;
*movex = 0x2d;
*movex = 0x20;
*movex = 0x54;
*movex = 0x61;
*movex = 0x73;
*movex = 0x63;
*movex = 0x68;
*movex = 0x65;
*movex = 0x6E;
*movex = 0x72;
*movex = 0x65;
*movex = 0x63;
*movex = 0x68;
*movex = 0x6e;
*movex = 0x65;
*movex = 0x72;

movexy = move_to(7, 21);
*movexy = 0;
*movex = 0x07;
movexy = move_to(5, 22);
*movexy = 0;
*movex = 0x48;
*movex = 0x6f;
*movex = 0x63;
*movex = 0x68;
movexy = move_to(3, 24);
*movexy = 0;
*movex = 0x07;
*movex = 0;
*movex = 0;
*movex = 0;
*movex = 0x07;
*movex = 0;
*movex = 0;
*movex = 0;
*movex = 0x07;
movexy = move_to(5, 25);
*movexy = 0;
*movex = 0x45;
*movex = 0x6e;
*movex = 0x74;
*movex = 0x65;
*movex = 0x72;
movexy = move_to(7, 27);
*movexy = 0;
*movex = 0x07;
movexy = move_to(5, 28);
*movexy = 0;
*movex = 0x52;
*movex = 0x75;
*movex = 0x6e;
*movex = 0x74;
*movex = 0x65;
*movex = 0x72;

movexy = move_to (15, 4);
}

void clear(unsigned int* movexy0, unsigned int* movex, unsigned int* movey) {

	*movexy0 = 0x00;

	for (int y = 0; y < 30; y++) {
		for (int x = 0; x < 80; x++){
			*movex = 0x00; 
		}

		*movey = 0x00;
	}

}

void button_press (int button, unsigned int* schalter) {

	while (Bit_Test(*schalter, button) == 1) {
	
	}

}

void hello (unsigned int* movexy, unsigned int*  movex, unsigned int* movey) {

    movexy = move_to(33, 14);
*movexy = 0;
*movex = 0x48;
*movex = 0x65;
*movex = 0x6c;
*movex = 0x6c;
*movex = 0x6f;
*movex = 0x20;
*movex = 0x57;
*movex = 0x6f;
*movex = 0x72;
*movex = 0x6c;
*movex = 0x64;
*movex = 0x21;
*movex = 0x03;


movexy = move_to(7, 21);
*movexy = 0;
*movex = 0x07;
movexy = move_to(3, 24);
*movexy = 0;
*movex = 0x07;
*movex = 0;
*movex = 0;
*movex = 0;
*movex = 0x07;
*movex = 0;
*movex = 0;
*movex = 0;
*movex = 0x07;
movexy = move_to(5, 25);
*movexy = 0;
*movex = 0x42;
*movex = 0x61;
*movex = 0x63;
*movex = 0x6b;
movexy = move_to(7, 27);
*movexy = 0;
*movex = 0x07;

}

void calculator(unsigned int* movexy, unsigned int*  movex, unsigned int* movey){

	movexy = move_to(33, 0);
	*movexy = 0;
	*movex = 0x54;
	*movex = 0x61;
	*movex = 0x73;
	*movex = 0x63;
	*movex = 0x68;
	*movex = 0x65;
	*movex = 0x6E;
	*movex = 0x72;
	*movex = 0x65;
	*movex = 0x63;
	*movex = 0x68;
	*movex = 0x6E;
	*movex = 0x65;
	*movex = 0x72;

	movexy = move_to(7, 21);
	*movexy = 0;
	*movex = 0x07;
	movexy = move_to(3, 24);
	*movexy = 0;
	*movex = 0x07;
	*movex = 0;
	*movex = 0;
	*movex = 0;
	*movex = 0x07;
	*movex = 0;
	*movex = 0;
	*movex = 0;
	*movex = 0x07;
	movexy = move_to(1, 25);
	*movexy = 0;
	*movex = 0x42;
	*movex = 0x61;
	*movex = 0x63;
	*movex = 0x6b;
	*movex = 0;
	*movex = 0;
	*movex = 0;
	*movex = 0;
	*movex = 0x45;
	*movex = 0x6e;
	*movex = 0x74;
	*movex = 0x65;
	*movex = 0x72;
	movexy = move_to(7, 27);
	*movexy = 0;
	*movex = 0x07;

}

void pri_num(int num, unsigned int* movex){
	int tmp = num;
	int ch = 0;
	int div[10];
	div[0] = 1000000000;
	div[1] = 100000000;
	div[2] = 10000000;
	div[3] = 1000000;
	div[4] = 100000;
	div[5] = 10000;
	div[6] = 1000;
	div[7] = 100;
	div[8] = 10;
	div[9] = 1;

	int i;
	int is_0 = 0;
	if(num < 0){
		*movex = 0x2d;
	}
	for(i = 0; i <= 9; i++){
		ch = p_div_mod(tmp, div[i], &tmp);
		if(is_0 != 0 || ch != 0 || i == 9){
			*movex = 0x30 + ch;
			is_0 = 1;
		}	
	}
}

void main(void)
{
unsigned int* movex = (unsigned int*) 0xFFFF8000;
unsigned int* movey = (unsigned int*) 0xFFFFC000;
unsigned int* movexy0 = (unsigned int*) 0xffff0000;
unsigned int* movexy = (unsigned int*) 0xffff0000;
unsigned int* led = (unsigned int*) 0x80000000;
unsigned int* schalter = (unsigned int*) 0x80000001;	


int status = 0;
int print = 1;


unsigned int schalter_press = 0;
int programm = 0;

int num_eing = 0;
int eing_1 = 0;
int eing_2 = 0;
int op = 0;
int err = 0;

*led = *schalter;
*movex = 0x65;
while (1) {
	//*led = status;
	switch (status) {
		case 0: 
				if (print != 0) {
					clear(movexy0, movex, movey);
					start(movexy, movex, movey); 
					print = 0;
				}
				schalter_press = *schalter;
				if (Bit_Test(schalter_press, 16) == 1) {
					status = programm + 1;
					button_press(16, schalter);		
				}
				if (Bit_Test(schalter_press, 17) == 1) {
					programm --;
					button_press(17, schalter);		

					if (programm < 0) {
						programm = 1;
						movexy = move_to(15, 5);
					} else 
						movexy = move_to(15, 4);

				}

				if (Bit_Test(schalter_press, 18) == 1) {
					programm ++;
					button_press(18, schalter);		

					if (programm > 1) {
						programm = 0;
						movexy = move_to(15, 4);
					} else {
						movexy = move_to(15, 5);
					}
				}
 
				break;
		case 1: 
				if (print != 1) {
					clear(movexy0, movex, movey);
					hello(movexy, movex, movey);
					print = 1;
				}
				schalter_press = *schalter;
				if (Bit_Test(schalter_press, 16) == 1) {
					status = 0;
					button_press(16, schalter);	
					programm = 0;	
				}		

				break;

		case 2:
				if (print != 2) {
					clear(movexy0, movex, movey);
					calculator(movexy, movex, movey);
					print = 2;
				}

				schalter_press = *schalter;
				if(Bit_Test(schalter_press, 19) == 1){
					status = 0;
					button_press(19, schalter);
					programm = 0;
					num_eing = 0;
				}
				if(Bit_Test(schalter_press, 20) == 1){
					button_press(20, schalter);
					*led = *schalter;
					switch(num_eing){
					case 0 :
						Bit_Clear(&schalter_press, 20);
						eing_1 = *schalter;
						num_eing++;
						movexy = move_to(20, 5);
						*movexy = 0;
						pri_num(eing_1, movex);
						*movex = 0;
						break;
					case 1 :
						Bit_Clear(&schalter_press, 20);
						op = *schalter;
						num_eing++;
						switch(op){
							case  0 : *movex = 0x2b; break;
							case  1 : *movex = 0x2d; break;
							case  2 : *movex = 0x2a; break;
							case  3 : *movex = 0x2f; break;
							default : *movex = 0x25; break;
						}
						//*movex = 0;
						break;
					case 2 :
						Bit_Clear_Range(&schalter_press, 16, 31);
						eing_2 = *schalter;
						num_eing++;
						pri_num(eing_2, movex);
						*movex = 0;
						*movex = 0x3d;
						//*movex = 0;
						switch(op){
							case  0 : eing_1 = eing_1 + eing_2; break;
							case  1 : eing_1 = eing_1 - eing_2; break;
							case  2 : eing_1 = mult(eing_1, eing_2); break;
							case  3 : if(eing_2 != 0){
										  eing_1 = p_div_mod(eing_1, eing_2, NULL);
									  } else {
										  err = 1;
									  }
									  break;
							default : if(eing_2 != 0){
										  p_div_mod(eing_1, eing_2, &eing_1);
									  } else {
										  err = 1;
									  }
									  break;
						}
						if(err == 0){
							pri_num(eing_1, movex);
						} else {
							*movex = 0x45;
							*movex = 0x52;
							*movex = 0x52;
							*movex = 0x4f;
							*movex = 0x52;
						}
						break;
					default :
						num_eing = 0;
						clear(movexy0, movex, movey);
						calculator(movexy, movex, movey);
						break;
				}

				break;

		default: status = 0; 

	}


}

}
}


