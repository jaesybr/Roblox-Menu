#import "Macros.h"

void setup() {
    [switches addSwitch3:NSSENCRYPT("test3")
        description:NSSENCRYPT("another button test")];

    [switches addSwitch2:NSSENCRYPT("test2")
        description:NSSENCRYPT("Test Button")];

    [switches addSwitch:NSSENCRYPT("test")
        description:NSSENCRYPT("Test Menu")];
}

void setupMenu() {
    [menu setFrameworkName:"UnityFramework"];

    menu = [[Menu alloc]  
            initWithTitle:NSSENCRYPT("")
            titleColor:[UIColor whiteColor]
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("Credits go to trapppp Do not Skid This!")
            headerColor:UIColorFromHex(0x000000)
            switchOffColor:[UIColor darkGrayColor]
            switchOnColor:UIColorFromHex(0x00ADF2)
            switchTitleFont:NSSENCRYPT("Copperplate-Bold")
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:UIColorFromHex(0xBD0000)
            maxVisibleSwitches:4
            menuWidth:450
            menuIcon:@""
            menuButton:@""];    

    setup();
}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    timer(5) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

        // Website link, remove it if you don't need it.
        [alert addButton: NSSENCRYPT("Subscribe To Me!!") actionBlock: ^(void) {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: NSSENCRYPT("https://www.youtube.com/@OfficialEmerald.ccBusiness")]];
            timer(3) {
                setupMenu();
            });
        }];

        [alert addButton: NSSENCRYPT("Load Menu") actionBlock: ^(void) {
            timer(5) {
                setupMenu();
            });
        }];    

        alert.shouldDismissOnTapOutside = NO;
        alert.customViewColor = [UIColor redColor];  // Change from purple to red
        alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   

        [alert showSuccess: nil
                subTitle:NSSENCRYPT("Trapppps First Successful Mod Menu Injection DO NOT SKID!!!") 
                closeButtonTitle:nil
                duration:99999999.0f];
    });
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}