# Stripe SDK ships optional "push provisioning" classes (adding a card to
# Apple/Google Pay) that reference react-native-stripe-sdk types we don't
# bundle. We don't use this feature — safe to silence R8's missing-class
# warnings for it instead of pulling in the whole react-native-stripe-sdk.
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
