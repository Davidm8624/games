def tick args
  args.state.player_x ||= 120 # ||= means that the value is 120 unless it is given a value elsewhere
  args.state.player_y ||= 280
  args.state.fireballs ||= []
  speed = 12
  player_w = 100
  player_h = 80
  
  #movement auto translates to arrowkeys & d-pad automaticly, no need 2 be specific
  if args.inputs.left
    args.state.player_x -= speed
  elsif args.inputs.right
    args.state.player_x += speed
  end
  
  if args.inputs.up
    args.state.player_y += speed
  elsif args.inputs.down
    args.state.player_y -= speed
  end
  
  #keeps player in-bounds
  if args.state.player_x + player_w > args.grid.w
    args.state.player_x = args.grid.w - player_w
  end
  
  if args.state.player_x < 0
    args.state.player_x = 0
  end
  
  if args.state.player_y + player_h > args.grid.h
    args.state.player_y = args.grid.h - player_h
  end
  
  if args.state.player_y < 0
    args.state.player_y = 0
  end
  
  #shoot, made acessable for left/right handed & controller
  if args.inputs.keyboard.key_down.z ||
    args.inputs.keyboard.key_down.j ||
    args.inputs.controller_one.key_down.a
    puts "Spit fireball!"
    args.state.fireballs << [args.state.player_x, args.state.player_y, 'fireball']
  end
  
  #makes the fireball move
  args.state.fireballs.each do |fireball|
    fireball[0] += speed + 3 #makes it go the speed of the dragon (speed) + 3 so that no matter the dragon speed the fireballs will be faster
  end
  
  #outputs fireballs
  args.outputs.labels <<[args.state.fireballs] # we are passing fireball array to output array, it gets flattened automaticly. yay
  
  #outputs player in the new position after evaluation, this should b last
  args.outputs.sprites << [args.state.player_x, args.state.player_y, player_w,
                           player_h, 'sprites/misc/dragon-0.png']
end
