3/30 변경사항
Ti = 9>27;	// Each CONV kernel do 9>27 multipliers at the same time

To = 16>8;	// Run 16>8 CONV kernels at the same time	

To * Ti = 216           //동시에 216개의 DSP 사용

Ti, To 관련 mac 개수 변경, mul, adder_tree 변경


기타 변경 안된사항 인지중