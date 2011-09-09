
var ledSize = 32;
var ledPadding = 1;
var ledColor = 'red';
var scrollDelay = 50;
var blurLevel = 0.25;

var leds = new Array();  var message = new Array(); var readOffset = 0; var displayWidth = 0; var letterSpacing = 1;
function setOpacity(led, amount) { var div = document.getElementById(led); div.lastChild.style.opacity = amount; }
function getOpacity(led) { var div = document.getElementById(led); if (div) { var opac = div.lastChild.style.opacity; if (opac == "") opac = 1; return opac; } }
function fadeOut(led) { var opac = getOpacity(led); if (opac > 0) { if (opac == 1) setOpacity(led,blurLevel); else setOpacity(led,opac - 0.1); var div = document.getElementById(led); if (div.fadeEvent != null) {window.clearTimeout(div.fadeEvent);} div.fadeEvent = window.setTimeout(function() { fadeOut(led); },scrollDelay); } else { if (div) {div.fadeEvent = null;} } }
function turnOn(led) { var div = document.getElementById(led); if (div) { if (div.fadeEvent != null) {window.clearTimeout(div.fadeEvent);} div.lastChild.style.opacity = 1; } }
function turnOff(led) { var div = document.getElementById(led); div.lastChild.style.opacity = 0; }
function createLedMatrix(width, height) { var matrix = ''; readOffset = - width; displayWidth = width; for (x = 0; x < width; x++) { for (y = 0; y < height; y++) { matrix += createLed(x, y); leds.push('l'+ x +'x' + y)} } document.getElementById('ledSet').innerHTML = matrix; allOff(); }
function createLed(x, y) { lc = ledColor; if (lc == 'rainbow') { lc = 'white'; if (y % 7 == 0) lc = 'red'; if (y % 7 == 1) lc = 'amber'; if (y % 7 == 2) lc = 'yellow'; if (y % 7 == 3) lc = 'green'; if (y % 7 == 4) lc = 'blue'; if (y % 7 == 5) lc = 'uv'; } return '<div id="l'+ x +'x'+ y +'" class="led" style="top:'+ y*(ledSize + ledPadding) +'px;left:' + x*(ledSize + ledPadding) + 'px;"><img src="leds/'+lc+'-off-'+ledSize+'.png" class="off"/><img src="leds/'+lc+'-on-'+ledSize+'.png" class="on"/></div>'; }
function allOff() {for (x in leds) turnOff(leds[x]); }
function allOn() { for (x in leds) turnOn(leds[x]); }
function scroll() { readOffset++; if (readOffset > message.length) readOffset = -displayWidth; redraw(); window.setTimeout(scroll, scrollDelay); }

function redraw() { 
	partialmessage = message.slice(readOffset, readOffset + displayWidth); 
	for (x in partialmessage) {
		for (y in partialmessage[x]) {
			if(x >= 0) { 
				if (partialmessage[x][y]) {
						turnOn('l'+x+'x'+y); 
					} else { 
						fadeOut('l'+x+'x'+y); 
						} 
					}
				} 
			} 
		} 


function addCharacter(c) { if (msg[c]) { for (x in msg[c]) { message.push(msg[msg[c][x]]); } for (x = 0; x < letterSpacing; x++) message.push(msg[0]); } } 
function setMessage(msg) { message = new Array(); msg = msg.toUpperCase(); msg = "     " + msg + " "; for(ch = 0; ch < msg.length; ch++) { char = msg.substr(ch,1); if (char=="0" || char=="1" || char=="2" || char=="3" || char=="4" || char=="5" || char=="6" || char=="7" || char=="8" || char=="9") addCharacter("n" + char); else addCharacter(char); } } 
