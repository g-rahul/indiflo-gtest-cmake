#include "app.h"
#include "main.h"

extern "C" {

void setup() {
    // For future episodes ;)
}

void loop() {

    while(1)
    {    
        HAL_GPIO_TogglePin(KH7_USERLED_GPIO_Port,KH7_USERLED_Pin);
        HAL_Delay(500U);
    }
}

}
