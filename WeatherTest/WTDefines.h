#define kGoogleKey @"AIzaSyDavVVjNAQcB5Uh6SDPjpYMIFfhf1Jx8bE"
#define kOpenWeatherKey @"2de143494c0b295cca9337e1e96b00e0"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

#define viewFromNib(_nib_name_,_owner_) [[[NSBundle mainBundle] loadNibNamed:_nib_name_ owner:_owner_ options:nil] objectAtIndex:0]
#define nibFromName(_name_) [UINib nibWithNibName:_name_ bundle:nil]
