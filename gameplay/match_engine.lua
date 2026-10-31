-- gameplay/match_engine.lua
-- Server-authoritative round, rally, scoring, and set progression logic.

local FSM = require(script.Parent.fsm)
local VectorMath = require(script.Parent.vector_math)

local MatchEngine = {}

MatchEngine.State = {
    Service = "Service",
    Rally = "Rally",
    PointAwarded = "PointAwarded",
    SetComplete = "SetComplete",
    MatchComplete = "MatchComplete",
}

MatchEngine.score = { A = 0, B = 0 }
MatchEngine.sets = { A = 0, B = 0 }
MatchEngine.touchCounter = 0
MatchEngine.maxTouchesPerTeam = 3

function MatchEngine.resetRound()
    MatchEngine.touchCounter = 0
    MatchEngine.score = { A = 0, B = 0 }
    return MatchEngine.State.Service
end

function MatchEngine.applyPoint(team)
    if team == "A" then
        MatchEngine.score.A += 1
    else
        MatchEngine.score.B += 1
    end

    MatchEngine.touchCounter = 0
    return MatchEngine.State.PointAwarded
end

function MatchEngine.checkSetWinner()
    if MatchEngine.sets.A >= 2 then
        return "A", MatchEngine.State.SetComplete
    end

    if MatchEngine.sets.B >= 2 then
        return "B", MatchEngine.State.SetComplete
    end

    return nil, MatchEngine.State.Rally
end

function MatchEngine.validateBall(ballPosition, ballVelocity)
    if not VectorMath.isInsideCourt(ballPosition) then
        return false, "OutOfBounds"
    end

    if ballPosition.Y < -1.5 then
        return false, "GroundHit"
    end

    if ballVelocity.Magnitude < 0.01 then
        return false, "Idle"
    end

    return true, nil
end

return MatchEngine
