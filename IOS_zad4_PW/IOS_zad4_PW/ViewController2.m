#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc]init];
    geocoder=[[CLGeocoder alloc]init];
}

-(void)getCurrentLocation:(id)sender{
    locationManager.delegate = self;
    if([locationManager respondsToSelector:@selector(requestWhenItUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"didFailWithError %@", error);
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your location" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.view setBackgroundColor:[UIColor blueColor]];
    }];
    
    [alertController addAction:okButton];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) locationManager:(CLLocationManager *)didUpdateLocations:(nonnull NSArray<CLLocation*>*)locations{
    NSLog(@"didUpdateLocations");
    
    CLLocation *currentLocation=[locations lastObject];
    if(currentLocation!=nil){
        _longitudeText.text=[NSString stringWithFormat:@"%.8f",currentLocation.coordinate.longitude];
        _latitudeText.text=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        [geocoder reverseGeocodeLocation:currentLocation
                       completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks,
                                           NSError * _Nullable error) {
            if(error==nil&&[placemarks count]>0){
                self->placemark=[placemarks lastObject];
                self->_addressText.text =[NSString stringWithFormat:@"%@%@\n%@ %@\n%@\n%@",
                                          self->placemark.postalCode,
                                          self->placemark.locality,
                                          self->placemark.administrativeArea,
                                          self->placemark.country];
            }else{
                NSLog(@"%@", error.debugDescription);
            }
        }];
    }
}


// Do any additional setup after loading the view.

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
