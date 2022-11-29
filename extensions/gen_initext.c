extern void ipt_statistic_init(void);
void init_extensions(void) {
        ipt_standard_init();
	ipt_statistic_init();
}

