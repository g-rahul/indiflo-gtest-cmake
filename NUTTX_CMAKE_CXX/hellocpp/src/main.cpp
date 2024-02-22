#include "HelloWorld.h"
#include <nuttx/config.h>


#define GTEST_ENABLE
#ifdef GTEST_ENABLE
#include <gtest/gtest.h>
static void gtest_init(int argc, char* argv[]) {

	::testing::InitGoogleTest();
	int result = RUN_ALL_TESTS();
	//std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;

    while(1)
    {   

    	//printf("Will be linked to gtest soon\n");

    	//std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;
    	//std::cout << "Testing programm finished. Awaiting shutdown." << std::endl;
    	//HAL_Delay(1000U);
    	//HAL_GPIO_TogglePin(KH7_USERLED_GPIO_Port,KH7_USERLED_Pin);
    }
}
#endif


extern "C"
{
        int hellocpp_main(int argc, FAR char *argv[])
        {

                CHelloWorld *pHelloWorld = new CHelloWorld();
                pHelloWorld->HelloWorld();

                CHelloWorld helloWorld;
                helloWorld.HelloWorld();
	            int argcs=1;
	            char args[]="Basic_Test";
	            char* argvs = &args[0];
                #ifdef GTEST_ENABLE
                // For future episodes ;)
	            gtest_init(argcs,&argvs);
                #endif
                delete pHelloWorld;
                return 0;
        }
}
