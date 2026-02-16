# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install image library
RUN pip install pillow

# Create image generation script
RUN printf '%s\n' \
'from PIL import Image, ImageDraw' \
'img = Image.new("RGB", (400, 400), "white")' \
'draw = ImageDraw.Draw(img)' \
'for x in range(0, 400, 40):' \
'    for y in range(0, 400, 40):' \
'        draw.rectangle([x, y, x+20, y+20], fill=(x%255, y%255, (x+y)%255))' \
'img.save("generated_image.png")' \
'print("Image generated: generated_image.png")' \
> generate_image.py

# Run image generation
CMD ["python", "generate_image.py"]
