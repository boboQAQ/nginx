upstream usermgmt_backend {
    server uiotstack-usermgmt:8080; 
}

upstream product_backend {
    server uiotstack-devicemgmt:8080; 
}

upstream monitor_backend {
    server uiotstack-monitor:8080; 
}

upstream edge_backend {
    server uiotstack-edgemgmt:8080; 
}

upstream ruleengine_backend {
    server uiotstack-ruleengine:8080;
}

upstream scriptparser_backend {
    server uiotstack-scriptparser:8080;
}

upstream deployment_backend {
    server uiotstack-deploymgmt:8080;
}

upstream hardwaremgmt_backend {
    server uiotstack-hardwaremgmt:8080;
}

upstream licensemgmt_backend {
    server uiotstack-licensemgmt:8080;
}

upstream ota_backend {
    server uiotstack-ota:8080;
}

upstream view_backend {
    server uiotstack-view:8080;
}
{{if .IPC }}
upstream ipc-backend {
    server uiotstack-ipcmgmt:8080;
}
{{end}}
server {
    listen       8080;

    location /api/v1/username{
        proxy_pass http://usermgmt_backend;
        client_max_body_size 200m;
    }
    
    location /api/v1/email{
        proxy_pass http://usermgmt_backend;
        client_max_body_size 200m;
    }

    location /api/v1/user/{
        proxy_pass http://usermgmt_backend;
        client_max_body_size 200m;
    }

    location /api/v1/project/{
        proxy_pass http://usermgmt_backend;
    }

    location /api/v1/enterprise/{
        proxy_pass http://usermgmt_backend;
    }

    location /api/v1/platform/{
        proxy_pass http://usermgmt_backend;
    }

    location /api/v1/product/{
        proxy_pass http://product_backend;
        client_max_body_size 200m;
    }

    location /api/v1/device/{
        proxy_pass http://product_backend;
        client_max_body_size 200m;
    }
    
    location /api/v1/topic/{
        proxy_pass http://product_backend;
        client_max_body_size 200m;
    }
    
    location /api/v1/mqtt/{
        proxy_pass http://product_backend;
        client_max_body_size 200m;
    }

    location /api/v1/gateway/{
        proxy_pass http://product_backend;
        client_max_body_size 200m;
    }

    location /api/v1/license/{
        proxy_pass http://licensemgmt_backend;
        client_max_body_size 200m;
    }

    location /api/v1/version{
        proxy_pass http://licensemgmt_backend;
        client_max_body_size 200m;
    }

    location /api/v1/monitor/{
        proxy_pass http://monitor_backend;
        client_max_body_size 200m;
    }

    location /api/v1/log/{
        proxy_pass http://monitor_backend;
        client_max_body_size 200m;
    }

    location /api/v1/operation/{
        proxy_pass http://monitor_backend;
        client_max_body_size 200m;
    }

    location /api/v1/driver/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/function/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/application/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/messagerouter/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/reinstall/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/config/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }
    
    location /api/v1/subdev/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/template/{
        proxy_pass http://edge_backend;
        client_max_body_size 200m;
    }

    location /api/v1/rule/{
        proxy_pass http://ruleengine_backend;
        client_max_body_size 200m;
    }

    location /api/v1/script/{
        proxy_pass http://scriptparser_backend;
        client_max_body_size 200m;
    }

    location /api/v1/rule_action/{
        proxy_pass http://ruleengine_backend;
        client_max_body_size 200m;
    }

    location /api/v1/deployment/{
        proxy_pass http://deployment_backend;
        client_max_body_size 200m;
    }

    location /api/v1/hardware/{
        proxy_pass http://hardwaremgmt_backend;
        client_max_body_size 200m;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
    }

    location /api/v1/ota/{
        proxy_pass http://ota_backend;
        client_max_body_size 200m;
    }

    location /api/v1/view/{
        proxy_pass http://view_backend;
        client_max_body_size 200m;
    }

    location /api/v1/service/{
        proxy_pass http://usermgmt_backend;
        client_max_body_size 200m;
    }
{{if .IPC }}
    location /api/v1/ipc/{
        proxy_pass http://ipc-backend;
        client_max_body_size 200m;
    }

    location /api/v1/screen/{
        proxy_pass http://ipc-backend;
        client_max_body_size 200m;
    }
{{end}}
}