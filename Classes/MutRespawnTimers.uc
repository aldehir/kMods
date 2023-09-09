class MutRespawnTimers extends Mutator
    config(RespawnTimers);

struct TimerConfig {
    var class<Pickup> PickupClass;
    var float Value;
};

var() config array<TimerConfig> RespawnTimer;

event PreBeginPlay() {
    Super.PreBeginPlay();
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant) {
    local Pickup P;
    local int i;

    P = Pickup(Other);
    bSuperRelevant = 0;

    if (P != None) {
        for (i = 0; i < RespawnTimer.Length; i++) {
            if (P.IsA(RespawnTimer[i].PickupClass.Name)) {
                P.RespawnTime = RespawnTimer[i].Value * Level.TimeDilation;
                log("Set Respawn Time of "@P.Name@"to"@RespawnTimer[i].Value);
            }
        }
    }

    return true;
}

defaultproperties
{
}
