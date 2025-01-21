extends Resource
class_name BearerResource

@export var name: String

# effectively constant, unless we have a skill that lets it get modified or something
@export var alignment: int  # -100 to 100

# hit points
@export var bond: int  # -100 to 100. maybe positive bond adds scaling for decisions

# stats modified by decisions (inflection stats)
@export var bravery: int  # -100 to 100
@export var compassion: int  # -100 to 100
@export var justice: int  # -100 to 100
@export var temperance: int  # -100 to 100

# longevity
@export var lifespan: int  # number of events 7-11
