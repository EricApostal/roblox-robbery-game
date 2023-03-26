local net = require( game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts").Client.client_networking )

print( net.get_coins() )
print( net.get_pets() )