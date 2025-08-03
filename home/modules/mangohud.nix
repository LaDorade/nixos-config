{
  programs.mangohud = {
    enable = true;
    settings = {
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      vram = true;
      ram = true;
      swap = true;
      fps = true;
      frametime = true;
      frame_timing = true;
      resolution = true;
    };
    settingsPerApplication = { pinta = { no_display = true; }; };
  };
}
