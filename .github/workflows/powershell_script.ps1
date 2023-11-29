Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class ScreenResolution {
    [DllImport("user32.dll")]
    public static extern int EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE devMode);
    [DllImport("user32.dll")]
    public static extern int ChangeDisplaySettings(ref DEVMODE devMode, int flags);

    public const int ENUM_CURRENT_SETTINGS = -1;
    public const int CDS_UPDATEREGISTRY = 0x01;
    public const int DISP_CHANGE_SUCCESSFUL = 0;

    [StructLayout(LayoutKind.Sequential)]
    public struct DEVMODE {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;
        public int dmPositionX;
        public int dmPositionY;
        public ScreenOrientation dmDisplayOrientation;
        public int dmDisplayFixedOutput;
        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmFormName;
        public short dmLogPixels;
        public int dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;
        public int dmDisplayFlags;
        public int dmDisplayFrequency;
        public int dmICMMethod;
        public int dmICMIntent;
        public int dmMediaType;
        public int dmDitherType;
        public int dmReserved1;
        public int dmReserved2;
        public int dmPanningWidth;
        public int dmPanningHeight;
    }

    public static void SetResolution(int width, int height) {
        DEVMODE vDevMode = new DEVMODE();
        vDevMode.dmDeviceName = new string(new char[32]);
        vDevMode.dmFormName = new string(new char[32]);
        vDevMode.dmSize = (short)Marshal.SizeOf(vDevMode);
        if (0 != EnumDisplaySettings(null, ENUM_CURRENT_SETTINGS, ref vDevMode)) {
            vDevMode.dmPelsWidth = width;
            vDevMode.dmPelsHeight = height;
            int iRet = ChangeDisplaySettings(ref vDevMode, CDS_UPDATEREGISTRY);
            if (iRet != DISP_CHANGE_SUCCESSFUL) {
                throw new Exception("Unable to change screen resolution");
            }
        }
    }
}
"@ -Namespace System.Windows.Forms -Using System.Windows.Forms

[System.Windows.Forms.ScreenResolution]::SetResolution(1920, 1080)
