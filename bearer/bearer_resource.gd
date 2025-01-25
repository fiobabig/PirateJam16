extends Resource
class_name BearerResource

@export var name: String
@export var portrait: Texture2D

# hit points
@export var bond: int  # -100 to 100. maybe positive bond adds scaling for decisions

# alignment
@export var bravery_inclination: float  # -1.0 to 1.0
@export var compassion_inclination: float  # -1.0 to 1.0
@export var justice_inclination: float  # -1.0 to 1.0
@export var temperance_inclination: float  # -1.0 to 1.0

@export var primary_inclination: Enums.Stats
@export var secondary_inclination: Enums.Stats

# stats modified by decisions (inflection stats)
@export var bravery: int  # -100 to 100
@export var compassion: int  # -100 to 100
@export var justice: int  # -100 to 100
@export var temperance: int  # -100 to 100

# longevity
@export var lifespan: int  # number of events 7-11
