from PIL import Image

picture = Image.open('./data.png')

(width, height) = picture.size

for x in range (0, width):
	for y in range (0, height):
		current_color = picture.getpixel( (x,y) )
		if y < 625 and current_color[0] > 125:
			picture.putpixel( (x,y), (255, 255, 255))

picture.save('test' + '.png')
