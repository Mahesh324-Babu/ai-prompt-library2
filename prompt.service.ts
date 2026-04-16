server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location /prompts/ {
        proxy_pass http://backend:8000/prompts/;
        proxy_set_header Host $host;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
