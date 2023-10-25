#include "app.h"
#include "main.h"
#include <stdio.h>
//#include <gtest/gtest.h>
#if 0
static void gtest_init(int argc, char* argv[]) {

	::testing::InitGoogleTest(&argc,argv);
	int result = RUN_ALL_TESTS();
	std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;

    while(1)
    {   

    	//printf("Will be linked to gtest soon\n");

    	std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;
    	//std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;
    	HAL_Delay(1000U);
    	HAL_GPIO_TogglePin(KH7_USERLED_GPIO_Port,KH7_USERLED_Pin);
    }
}
#endif


#if 0
char *getcwd (char *__buf, size_t __size)
{
	UNUSED(__buf);
	UNUSED(__size);
	return NULL;
}

int	mkdir (const char *_path, mode_t __mode )
{
	UNUSED(_path);
	UNUSED(__mode);
	return 0;
}
#endif

extern "C" {

void setup() {
    // For future episodes ;)
}


void loop() {
	int argc=1;
	char args[]="Basic_Test";
	char* argv = &args[0];
    // For future episodes ;)
	//gtest_init(argc,&argv);
}

}
