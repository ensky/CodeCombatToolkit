@getGolds = (lowerBound) ->
    @findItems().filter (item) ->
        item.type == 'coin' and item.value >= lowerBound

@getTotalEnemyHealth = (distance) ->
    enemies = @findEnemies().filter (enemy) -> @distanceTo(enemy) < distance
    enemies.reduce ((sum, enemy) -> sum + enemy.health), 0

# Move to a position with a step
@stepMove = (position, movement, tolorent) ->
    [sx, sy, px, py] = [@pos.x, @pos.y, position[0], position[1]]
    if Math.abs(sx - px) + Math.abs(sy - py) < tolorent
        return true
    dx = Math.abs(px - sx)
    dy = Math.abs(py - sy)
    dx = if dx <= movement then dx else movement
    dy = if dy <= movement then dy else movement
    dx = dx * (if px > sx then 1 else -1)
    dy = dy * (if py > sy then 1 else -1)
    @moveXY(sx + dx, sy + dy)
    return false


# Command parser for level1s
@cmdParser = (cmds) ->
    cmdArray = cmds.split ""
    Fn = {}
    Fn.U = 'moveUp'
    Fn.D = 'moveDown'
    Fn.L = 'moveLeft'
    Fn.R = 'moveRight'
    @[Fn[cmd]]() for cmd in cmdArray

# Usage
C = "RRURRRDRDRRRRR"
@cmdParser C