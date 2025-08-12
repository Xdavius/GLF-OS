{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  
  options.glf.system.enable = lib.mkOption {
    description = "Enable GLF systems configurations";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.system.enable {

    time.hardwareClockInLocalTime = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs-unstable; [
        intel-gpu-tools
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        libva
        vulkan-loader
        vulkan-validation-layers
      ];
      extraPackages32 = with pkgs-unstable; [
        intel-gpu-tools
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        libva
       
      ];
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25;
      priority = 5;
    };

    nix = {
      optimise = {
        automatic = true;
        dates = [ "weekly" ];
      };
      settings = {
        auto-optimise-store = true;
      };
    };
    
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [ libxcb-icccm libxkbcommon alsa-lib atk brotli cairo cups curlWithGnuTls dbus dbus-glib elfutils expat ffmpeg fontconfig freetype fuse3 gdk-pixbuf glew glib gobject-introspection gsettings-desktop-schemas gst_all_1.gstreamer gst_all_1.gst-plugins-ugly gst_all_1.gst-plugins-base gtk3 harfbuzz hpl icu json-glib libbsd libcap libdrm libelf libgbm libgcrypt libGL libGLU libidn2 libjpeg libogg libpng libpsl librsvg libtiff libuuid libva libvdpau libvorbis libvpx libxcrypt libxkbcommon linuxPackages.nvidia_x11 mesa.llvmPackages.llvm.lib mono nghttp2.lib nspr nss ocl-icd pango pkcs11helper pipewire procps rtmpdump rocmPackages.clr.icd sane-backends SDL_image SDL_mixer SDL_ttf SDL2_image SDL2_mixer SDL2_ttf shared-mime-info skia sudo systemd udev vulkan-loader vulkan-tools wayland xorg.libICE xorg.libpciaccess xorg.libSM xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXcursor xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXft xorg.libXi xorg.libXinerama xorg.libXmu xorg.libXrandr xorg.libXrender xorg.libXScrnSaver xorg.libxshmfence xorg.libXt xorg.libXxf86vm ];
};

}
