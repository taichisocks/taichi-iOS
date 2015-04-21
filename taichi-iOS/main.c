//
//  main.c
//  taichiOSX
//
//  Created by taichi on 15/4/20.
//  Copyright (c) 2015 taichi. All rights reserved.
//

#include "main.h"

#include <pthread.h>
#include <stdlib.h>
#include <string.h>

#include "../shadowsocks-libev/shadowsocks-libev/src/shadowsocks.h"

static char* g_remote_host = NULL;
static int g_remote_port = 0;
static char* g_method      = NULL;
static char* g_password    = NULL;
static char* g_local_host  = NULL;
static int g_local_port  = 0;


static void* proxy_thread(void* params)
{
    const profile_t profile = {
        .remote_host = g_remote_host,
        .local_addr = g_local_host,
        .method = g_method,
        .password = g_password,
        .remote_port = g_remote_port,
        .local_port = g_local_port,
        .timeout = 600,
        .acl = NULL,
        .log = NULL,
        .fast_open = 0,
        .udp_relay = 0,
        .verbose = 0
    };
    
    printf("shadowsocks start\n");
    start_ss_local_server(profile);
    printf("shadowsocks end\n");
    return NULL;
}

#define COPY_STR(name, des) if(des){free(des);}des=(char*)malloc(strlen(name)+1);memset(des,0,strlen(name)+1);memcpy(des,name,strlen(name));

void startProxyWithConfig(const char* remoteHost, int remotePort, const char* method, const char* password, const char* localHost, int localPort)
{
    COPY_STR(remoteHost, g_remote_host);
    g_remote_port = remotePort;
    COPY_STR(method,     g_method);
    COPY_STR(password,   g_password);
    COPY_STR(localHost,  g_local_host);
    g_local_port = localPort;
    
    printf("%s:%d, %s, %s, %s:%d\n", g_remote_host, g_remote_port, g_method, g_password, g_local_host, g_local_port);
    
    pthread_t tid;
    pthread_create(&tid, NULL, proxy_thread, NULL);
}
