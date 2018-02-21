import Foundation

print("SDL Version: \(SDL.GetVersion())")

SDL.Init(system: [.video, .audio, .events])
SDL_Image.Init()

for driver in SDL.Renderer.GetDriversInfos() {
    print("\(driver.name) min: \(driver.maxTextureWidth) max: \(driver.maxTextureHeight)")
}

var window = SDL.Window(title: "Hello World!", x: 100, y: 100, width: 640, height: 480);
var renderer = SDL.Renderer(window: window, flags: .software)

renderer.drawColor = Color.black
let _ = renderer.drawColor

let surface = SDL.Surface(width: 50, height: 50, pixelFormat: .rgba8888)
//surface.FillRect(rectangle: Rectangle(x: 1, y: 1, width: 10, height: 10), color: Color(red: 255, green: 0, blue: 0))
surface.Fill(color: Color(red: 255, green: 0, blue: 0))

let surface2 = SDL.Surface(filename: "Axel.png")!

//let texture = Texture(renderer: renderer, fromSurface: surface)
let texture2 = SDL.Texture(renderer: renderer, fromSurface: surface2)
let texture3 = SDL.Texture(renderer: renderer, filename: "Axel.png")!

var offset = 150

var running = true

while running {

    if let event = SDL.PollEvent() {
        
        switch event.id {
        
        case .quit:
            running = false
        
        case .keyDown:
            print("keydown")
            if let keyboardEvent = event as? SDL.KeyboardEvent {
                switch keyboardEvent.keySym.scancode {
                case .escape:
                    running = false

                case .enter:
                    SDL.ShowSimpleMessageBox(title: "patate", message: "salut patate")

                default:
                    offset /= 2
                }
                
                if keyboardEvent.keySym.mod.contains([.leftShift, .rightShift]) {
                    print("LEFT & RIGHT SHIIIIIIFT")
                }
            }
        
        case .keyUp:
            print("keyup")
            
        default:
            ()
        }
    }
    
    renderer.clear()
    
//    renderer.copy(texture: texture, position: Point(x: 50, y: 50))
    renderer.copy(texture: texture2, destinationRect: Rectangle(x: 200, y: 0, width: Int(texture2.width / 4), height: Int(texture2.height / 4)))
    
    renderer.drawBlendMode = .none
    texture3.alphaMod = 85
    
    var rect = Rectangle(x: 0, y: 200, width: Int(texture3.width / 4), height: Int(texture3.height / 4))
    
    rect.x = 200 - offset
    texture3.colorMod = Color.red_
    renderer.copy(texture: texture3, destinationRect: rect)
    
    rect.x = 200
    texture3.colorMod = Color.green_
    renderer.copy(texture: texture3, destinationRect: rect)
    
    rect.x = 200 + offset
    texture3.colorMod = Color.blue_
    renderer.copy(texture: texture3, destinationRect: rect)
    
    renderer.present()
}

//print("\(SDL.GetTicks())")
//SDL.Delay(ms: 1000)
//print("\(SDL.GetTicks())")

SDL_Image.Quit()
SDL.Quit()
