	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	down
	.type	down, @function
down:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	movsd	QWORD PTR -24[rbp], xmm0 ## передает через xmm0 double x
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax ## передает через xmm0 double x
	call	sqrt@PLT
	movq	rax, xmm0 
	movq	xmm0, rax
	 ## floor(sqrt(x))
	call	floor@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR -8[rbp] 
	movq	rax, xmm0
	movq	xmm0, rax ## передает через xmm0 n2
	leave
	ret
	.size	down, .-down
	.globl	up
	.type	up, @function
up:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	movsd	QWORD PTR -24[rbp], xmm0 ## передает через xmm0 double x
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax ## передает через xmm0 double x
	call	sqrt@PLT
	movq	rax, xmm0 ## floor(sqrt(x))
	movq	xmm0, rax
	call	ceil@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax ## передает через xmm0 n2
	leave
	ret
	.size	up, .-up
	.section	.rodata
.LC0:
	.string	"r"
	.align 8
.LC1:
	.string	"/home/artyom/CLionProjects/untitled6/text"
.LC2:
	.string	"%lf"
.LC3:
	.string	"x = %lf\n"
.LC5:
	.string	"Insert x > -1"
.LC8:
	.string	"x = %f\n"
.LC13:
	.string	"Answer: %f"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 208
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, .LC0[rip]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT ##  f = fopen(...)
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -192[rbp]
	mov	rax, QWORD PTR -48[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT ##fscanf(f, "%lf", &x);
	mov	rax, QWORD PTR -192[rbp]
	movq	xmm0, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("x = %lf\n", x);
	mov	DWORD PTR -204[rbp], 0 ## int flag = 0;
	movsd	xmm1, QWORD PTR -192[rbp]  
	movsd	xmm0, QWORD PTR .LC4[rip] ## -1
	comisd	xmm0, xmm1
	jb	.L39
	## if (x <= -1){
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT ## printf("Insert x > -1");
	jmp	.L8
.L39:
	movsd	xmm1, QWORD PTR -192[rbp]
	pxor	xmm0, xmm0 ## 0 
	comisd	xmm0, xmm1 ## x <= 0
	jb	.L9
	movsd	xmm0, QWORD PTR -192[rbp]
	movsd	xmm1, QWORD PTR .LC4[rip] ## -1 
	comisd	xmm0, xmm1 ##  x > -1
	jbe	.L9
	movsd	xmm0, QWORD PTR -192[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	movsd	QWORD PTR -192[rbp], xmm0
	mov	rax, QWORD PTR -192[rbp]
	movq	xmm0, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("x = %f\n", x);
	movsd	xmm0, QWORD PTR .LC9[rip] ## double res = 1;
	movsd	QWORD PTR -184[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC10[rip] ## double i1 = 2;
	movsd	QWORD PTR -176[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC11[rip] ## double i2 = 3;
	movsd	QWORD PTR -168[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC9[rip] 
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -176[rbp] ## (1 / i1)
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1 ## (1 / i1) * x
	movsd	QWORD PTR -160[rbp], xmm0
	movsd	xmm0, QWORD PTR -184[rbp]
	subsd	xmm0, QWORD PTR -160[rbp] ##  res -= part;
	movsd	QWORD PTR -184[rbp], xmm0 
	movsd	xmm1, QWORD PTR -176[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip] 
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -176[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -176[rbp] ## 1 / i1
	movsd	xmm0, QWORD PTR -192[rbp]
	## part *= x * (1 / i1);
	
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -160[rbp]
	mulsd	xmm0, xmm1   
	movsd	QWORD PTR -160[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -184[rbp]
	subsd	xmm0, QWORD PTR -160[rbp] ## res -= part;
	movsd	QWORD PTR -184[rbp], xmm0
	movsd	xmm1, QWORD PTR -176[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2; 
	movsd	QWORD PTR -176[rbp], xmm0
	jmp	.L12
.L13:
	movsd	xmm0, QWORD PTR -160[rbp]
	mulsd	xmm0, QWORD PTR -168[rbp] ## part *= i2;
	movsd	QWORD PTR -160[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -176[rbp] ## 1 / i1
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -160[rbp]
	mulsd	xmm0, xmm1
	
	movsd	QWORD PTR -160[rbp], xmm0
	movsd	xmm0, QWORD PTR -184[rbp]
	subsd	xmm0, QWORD PTR -160[rbp] ## res -= part;
	movsd	QWORD PTR -184[rbp], xmm0
	movsd	xmm1, QWORD PTR -176[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -176[rbp], xmm0
	movsd	xmm1, QWORD PTR -168[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i2 += 2;
	movsd	QWORD PTR -168[rbp], xmm0
.L12:
	movsd	xmm0, QWORD PTR -160[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC12[rip]
	ja	.L13  ## (fabs(part) > 0.0005)
	mov	rax, QWORD PTR -184[rbp]
	movq	xmm0, rax
	lea	rax, .LC13[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("Answer: %f", res);
	jmp	.L8
.L9:
	movsd	xmm1, QWORD PTR -192[rbp]
	movsd	xmm0, QWORD PTR .LC9[rip]
	comisd	xmm0, xmm1
	jbe	.L14 ## ! x < 1
	movsd	xmm0, QWORD PTR -192[rbp]
	pxor	xmm1, xmm1
	comisd	xmm0, xmm1
	jbe	.L14 ## ! x > 0
	movsd	xmm0, QWORD PTR .LC9[rip]
	movsd	QWORD PTR -152[rbp], xmm0 ## double res = 1;
	movsd	xmm0, QWORD PTR .LC10[rip]
	movsd	QWORD PTR -144[rbp], xmm0 ##  double i1 = 2;
	movsd	xmm0, QWORD PTR .LC11[rip]
	movsd	QWORD PTR -136[rbp], xmm0 ## double i2 = 3;
	movsd	xmm0, QWORD PTR .LC9[rip]
	## part = (1 / i1) * x;
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -128[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -152[rbp]
	addsd	xmm0, QWORD PTR -128[rbp] ## res += part;
	movsd	QWORD PTR -152[rbp], xmm0
	movsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ##  i1 += 2;
	movsd	QWORD PTR -144[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	## part *= x * (1 / i1);
	divsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -128[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -128[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -152[rbp]
	subsd	xmm0, QWORD PTR -128[rbp] ##  res -= part;
	movsd	QWORD PTR -152[rbp], xmm0
	movsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -144[rbp], xmm0
	mov	DWORD PTR -200[rbp], 0 ## int i = 0;
	jmp	.L17
.L20:
	movsd	xmm0, QWORD PTR -128[rbp]
	mulsd	xmm0, QWORD PTR -136[rbp] ## part *= i2;
	movsd	QWORD PTR -128[rbp], xmm0
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -128[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -128[rbp], xmm0
	## if (i == 0) {
	cmp	DWORD PTR -200[rbp], 0
	##  else {
	jne	.L18
	movsd	xmm0, QWORD PTR -152[rbp]
	addsd	xmm0, QWORD PTR -128[rbp] ## res += part;
	movsd	QWORD PTR -152[rbp], xmm0
	jmp	.L19
.L18:
	movsd	xmm0, QWORD PTR -152[rbp]
	subsd	xmm0, QWORD PTR -128[rbp] ## res -= part;
	movsd	QWORD PTR -152[rbp], xmm0
.L19:
	neg	DWORD PTR -200[rbp] ##   i *= -1;
	movsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -144[rbp], xmm0
	movsd	xmm1, QWORD PTR -136[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ##  i2 += 2;
	movsd	QWORD PTR -136[rbp], xmm0
.L17:
	movsd	xmm0, QWORD PTR -128[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC12[rip]
	## (fabs(part) > 0.0005)
	ja	.L20
	mov	rax, QWORD PTR -152[rbp]
	movq	xmm0, rax
	lea	rax, .LC13[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("Answer: %f", res);
	jmp	.L8
.L14:
	movsd	xmm1, QWORD PTR -192[rbp]
	movsd	xmm0, QWORD PTR .LC9[rip]
	addsd	xmm0, xmm1 ## x += 1;
	movsd	QWORD PTR -192[rbp], xmm0
	mov	rax, QWORD PTR -192[rbp]
	movq	xmm0, rax ## передает через xmm0 double x
	call	down ## double n1 = down(x);
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -192[rbp]
	movq	xmm0, rax ## передает через xmm0 double x
	call	up ## double n2 = up(x);
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	## if ((x - (n1 * n1)) < ((n2 * n2) - x)) {
	movsd	xmm1, QWORD PTR -192[rbp]
	movsd	xmm0, QWORD PTR -40[rbp]
	mulsd	xmm0, xmm0
	subsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -32[rbp]
	mulsd	xmm0, xmm0
	movsd	xmm2, QWORD PTR -192[rbp]
	subsd	xmm0, xmm2
	comisd	xmm0, xmm1
	jbe	.L40
	## n3 = n1 * n1;
        ## x = ((x - n3) / n3);
	movsd	xmm0, QWORD PTR -40[rbp]
	mulsd	xmm0, xmm0
	movsd	QWORD PTR -120[rbp], xmm0
	movsd	xmm0, QWORD PTR -192[rbp]
	subsd	xmm0, QWORD PTR -120[rbp]
	divsd	xmm0, QWORD PTR -120[rbp]
	movsd	QWORD PTR -192[rbp], xmm0
	
	jmp	.L23
.L40: ## } else {
	## n3 = n2 * n2;
        ## x = ((n3 - x) / n3);
	movsd	xmm0, QWORD PTR -32[rbp]
	mulsd	xmm0, xmm0
	movsd	QWORD PTR -120[rbp], xmm0
	movsd	xmm1, QWORD PTR -192[rbp]
	movsd	xmm0, QWORD PTR -120[rbp]
	subsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -120[rbp]
	movsd	QWORD PTR -192[rbp], xmm0 
	
	mov	DWORD PTR -204[rbp], 1 ## flag = 1;
.L23:
	cmp	DWORD PTR -204[rbp], 0 ##  if (!flag) {
	jne	.L24 ## == 1
	movsd	xmm0, QWORD PTR .LC9[rip]
	movsd	QWORD PTR -112[rbp], xmm0 ## double res = 1;
	movsd	xmm0, QWORD PTR .LC10[rip]
	movsd	QWORD PTR -104[rbp], xmm0 ## double i1 = 2;
	movsd	xmm0, QWORD PTR .LC11[rip]
	movsd	QWORD PTR -96[rbp], xmm0 ## double i2 = 3;
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	## part = (1 / i1) * x;
	divsd	xmm1, QWORD PTR -104[rbp] 
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -88[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -112[rbp]
	addsd	xmm0, QWORD PTR -88[rbp] ## res += part;
	movsd	QWORD PTR -112[rbp], xmm0
	movsd	xmm1, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -104[rbp], xmm0
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -88[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -88[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -112[rbp]
	subsd	xmm0, QWORD PTR -88[rbp] ## res -= part;
	movsd	QWORD PTR -112[rbp], xmm0
	movsd	xmm1, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -104[rbp], xmm0
	mov	DWORD PTR -196[rbp], 0 ## int i = 0;
	## double per = 0.0005 * sqrt(n3);
	mov	rax, QWORD PTR -120[rbp]
	movq	xmm0, rax
	call	sqrt@PLT
	movsd	xmm1, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	
	jmp	.L25
.L28:
	movsd	xmm0, QWORD PTR -88[rbp]
	mulsd	xmm0, QWORD PTR -96[rbp] ##  part *= i2;
	movsd	QWORD PTR -88[rbp], xmm0
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -88[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -88[rbp], xmm0
	
	cmp	DWORD PTR -196[rbp], 0 ##  if (i == 0) {
	jne	.L26 ## != 0 
	movsd	xmm0, QWORD PTR -112[rbp]
	addsd	xmm0, QWORD PTR -88[rbp] ## res += part;
	movsd	QWORD PTR -112[rbp], xmm0
	jmp	.L27 
.L26:
	movsd	xmm0, QWORD PTR -112[rbp]
	subsd	xmm0, QWORD PTR -88[rbp] ## res -= part;
	movsd	QWORD PTR -112[rbp], xmm0
.L27:
	neg	DWORD PTR -196[rbp] ## i *= -1;
	movsd	xmm1, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1  ## i1 += 2;
	movsd	QWORD PTR -104[rbp], xmm0
	movsd	xmm1, QWORD PTR -96[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i2 += 2;
	movsd	QWORD PTR -96[rbp], xmm0
.L25:
	## while (fabs(part) > per) {
	movsd	xmm0, QWORD PTR -88[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR -16[rbp]
	ja	.L28
	## res *= sqrt(n3);
	mov	rax, QWORD PTR -120[rbp]
	movq	xmm0, rax
	call	sqrt@PLT
	movsd	xmm1, QWORD PTR -112[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -112[rbp], xmm0
	
	mov	rax, QWORD PTR -112[rbp]
	movq	xmm0, rax
	lea	rax, .LC13[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("Answer: %f", res);
	jmp	.L8
.L24:
	movsd	xmm0, QWORD PTR .LC9[rip]
	movsd	QWORD PTR -80[rbp], xmm0 ## double res = 1;
	movsd	xmm0, QWORD PTR .LC10[rip]
	movsd	QWORD PTR -72[rbp], xmm0 ##  double i1 = 2;
	movsd	xmm0, QWORD PTR .LC11[rip]
	movsd	QWORD PTR -64[rbp], xmm0 ## double i2 = 3;
	## part = (1 / i1) * x;
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -80[rbp]
	subsd	xmm0, QWORD PTR -56[rbp] ##  res -= part;
	movsd	QWORD PTR -80[rbp], xmm0
	movsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -72[rbp], xmm0
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -56[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -80[rbp]
	subsd	xmm0, QWORD PTR -56[rbp] ## res -= part;
	movsd	QWORD PTR -80[rbp], xmm0
	movsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -72[rbp], xmm0
	## double per = 0.0005 * sqrt(n3);
	mov	rax, QWORD PTR -120[rbp]
	movq	xmm0, rax
	call	sqrt@PLT
	movsd	xmm1, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	
	jmp	.L29
.L30:
	movsd	xmm0, QWORD PTR -56[rbp]
	mulsd	xmm0, QWORD PTR -64[rbp] ## part *= i2;
	movsd	QWORD PTR -56[rbp], xmm0
	## part *= x * (1 / i1);
	movsd	xmm0, QWORD PTR .LC9[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR -192[rbp]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -56[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -80[rbp]
	subsd	xmm0, QWORD PTR -56[rbp] ## res -= part;
	movsd	QWORD PTR -80[rbp], xmm0
	movsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i1 += 2;
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	xmm1, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	addsd	xmm0, xmm1 ## i2 += 2;
	movsd	QWORD PTR -64[rbp], xmm0
.L29:	
	## while (fabs(part) > per) {
	movsd	xmm0, QWORD PTR -56[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR -24[rbp]
	ja	.L30
	mov	rax, QWORD PTR -120[rbp]
	movq	xmm0, rax
	## ##  res *= sqrt(n3);
	call	sqrt@PLT 
	movsd	xmm1, QWORD PTR -80[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -80[rbp], xmm0
	
	mov	rax, QWORD PTR -80[rbp]
	movq	xmm0, rax
	lea	rax, .LC13[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT ## printf("Answer: %f", res);
.L8:
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fclose@PLT ## fclose(f);
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L32
	call	__stack_chk_fail@PLT
.L32:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC4:
	.long	0
	.long	-1074790400
	.align 16
.LC7:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC9:
	.long	0
	.long	1072693248
	.align 8
.LC10:
	.long	0
	.long	1073741824
	.align 8
.LC11:
	.long	0
	.long	1074266112
	.align 8
.LC12:
	.long	-755914244
	.long	1061184077
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
