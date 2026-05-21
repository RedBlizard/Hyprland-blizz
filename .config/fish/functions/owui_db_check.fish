function owui_db_check
    docker exec -it postgres psql -U root -d openwebui -c "SELECT COUNT(*) FROM memories;"
    docker exec -it postgres psql -U root -d openwebui -c "SELECT COUNT(*) FROM documents;"
end
