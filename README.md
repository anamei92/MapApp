Name: Ana Mei 
Project Name: Map App

Notes:

For this Program, if the app enters the background, it will stop updating for new locations. The arrow next to the battery will disappear after about 10 sec wait. It will restart again once the app is brought to the foreground again.

Zoom Level:

The Current Zoom Level:

MKCoordinateSpan span;
span.latitudeDelta=10;
span.longitudeDelta=10;

With each added pin, the view will be adjusted to center on that pin.