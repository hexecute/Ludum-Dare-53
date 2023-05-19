const CRACKED = 5

const tiles = {
    -1: {
        'title': 'empty',
        'passable': false,
    },
    3: {
        'title': 'open',
        'passable': true,
    },
    4: {
        'title': 'wall',
        'passable': false,
        
    },
    5: {
        'title': 'cracked',
        'passable': true,
        
    },
    # HX: Figure out what's broken with this
    6: {
        'title': 'pit',
        'passable': false,
        
    },
}

static func is_passable(tile_id: int):
    return tiles[tile_id].passable
