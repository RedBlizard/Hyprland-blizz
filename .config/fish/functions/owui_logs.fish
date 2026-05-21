function owui_logs
    set CONTAINER docker-setup-open-webui-1
    docker logs $CONTAINER | grep -i "filter\|memory\|document"
end
