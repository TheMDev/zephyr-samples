#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/sys/printk.h>

LOG_MODULE_REGISTER(multidomain_netcore_main, LOG_LEVEL_DBG);

int main(void)
{
    int cnt = 0;

    while (1)
    {
        LOG_INF("loop: %d", cnt++);
        k_sleep(K_SECONDS(1));
    }
    return 0;
}
