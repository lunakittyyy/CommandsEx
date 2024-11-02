using CommandsEx.Patches;
using GDWeave;

namespace CommandsEx;

public class Mod : IMod {
    public static Mod Instance;

    public Mod(IModInterface modInterface) {
        Instance = this;
        modInterface.RegisterScriptMod(new ChatPatch());
    }

    public void Dispose() {
        
    }
}
