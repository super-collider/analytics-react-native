# @metarouter/analytics-react-native

The hassle-free way to add analytics to your React-Native app.

[![CircleCI](https://circleci.com/gh/segmentio/analytics-react-native.svg?style=svg)](https://circleci.com/gh/segmentio/analytics-react-native) [![codecov](https://codecov.io/gh/segmentio/analytics-react-native/branch/develop/graph/badge.svg)](https://codecov.io/gh/segmentio/analytics-react-native) [![npm](https://img.shields.io/npm/v/@metarouter/analytics-react-native.svg)](https://www.npmjs.com/package/@metarouter/analytics-react-native)

<div align="center">
  <img src="https://user-images.githubusercontent.com/1385202/73848627-246de280-4831-11ea-8fcf-06f2d6f451e3.png"/>
  <p><b><i>You can't fix what you can't measure</i></b></p>
</div>

Analytics helps you measure your users, product, and business. It unlocks insights into your app's funnel, core business metrics, and whether you have product-market fit.

## How to get started

1. **Collect analytics data** from your app(s).
   - The top 200 Segment companies collect data from 5+ source types (web, mobile, server, CRM, etc.).
2. **Send the data to analytics tools** (for example, Google Analytics, Amplitude, Mixpanel).
   - Over 250+ Segment companies send data to eight categories of destinations such as analytics tools, warehouses, email marketing and remarketing systems, session recording, and more.
3. **Explore your data** by creating metrics (for example, new signups, retention cohorts, and revenue generation).
   - The best Segment companies use retention cohorts to measure product market fit. Netflix has 70% paid retention after 12 months, 30% after 7 years.

[Segment](https://segment.com) collects analytics data and allows you to send it to more than 250 apps (such as Google Analytics, Mixpanel, Optimizely, Facebook Ads, Slack, Sentry) just by flipping a switch. You only need one Segment code snippet, and you can turn integrations on and off at will, with no additional code. [Sign up with Segment today](https://app.segment.com/signup).

### Why?

1. **Power all your analytics apps with the same data**. Instead of writing code to integrate all of your tools individually, send data to Segment, once.

2. **Install tracking for the last time**. We're the last integration you'll ever need to write. You only need to instrument Segment once. Reduce all of your tracking code and advertising tags into a single set of API calls.

3. **Send data from anywhere**. Send Segment data from any device, and we'll transform and send it on to any tool.

4. **Query your data in SQL**. Slice, dice, and analyze your data in detail with Segment SQL. We'll transform and load your customer behavioral data directly from your apps into Amazon Redshift, Google BigQuery, or Postgres. Save weeks of engineering time by not having to invent your own data warehouse and ETL pipeline.

   For example, you can capture data on any app:

   ```js
   analytics.track('Order Completed', { price: 99.84 })
   ```

   Then, query the resulting data in SQL:

   ```sql
   select * from app.order_completed
   order by price desc
   ```

<!-- ### 🚀 Startup Program

<div align="center">
  <a href="https://segment.com/startups"><img src="https://user-images.githubusercontent.com/16131737/53128952-08d3d400-351b-11e9-9730-7da35adda781.png" /></a>
</div>
If you are part of a new startup  (&lt;$5M raised, &lt;2 years since founding), we just launched a new startup program for you. You can get a Segment Team plan  (up to <b>$25,000 value</b> in Segment credits) for free up to 2 years — <a href="https://segment.com/startups/">apply here</a>!
 -->

## Prerequisite

#### iOS

- CocoaPods (**recommended**)
  - Don't have CocoaPods setup? Follow [these instructions](https://facebook.github.io/react-native/docs/integration-with-existing-apps#configuring-cocoapods-dependencies).
- or [manually install `Analytics`](#ios-support-without-cocoapods)

## Installation

```bash
$ yarn add @metarouter/analytics-react-native
$ yarn react-native link
```

## Usage

See the [API docs](packages/core/docs/classes/analytics.client.md) for more details.

<!-- prettier-ignore -->
```js
import analytics from '@metarouter/analytics-react-native'

analytics
    .setup('writeKey', {
        using: [],
        recordScreenViews: true,
        trackAppLifecycleEvents: true,
        trackAttributionData: true,

        android: {
            flushInterval: 60,
            collectDeviceId: true
        },
        ios: {
            trackAdvertising: true,
            trackDeepLinks: true
        }
    })
    .then(() =>
        console.log('Analytics is ready')
    )
    .catch(err =>
        console.error('Something went wrong', err)
    )

analytics.track('Pizza Eaten')
analytics.screen('Home')
```

## Troubleshooting

### iOS support without CocoaPods

<!-- Based on https://segment.com/docs/sources/mobile/ios/#dynamic-framework-for-manual-installation -->

We **highly recommend** using Cocoapods.

However, if you cannot use Cocoapods, you can manually install our dynamic framework allowing you to send data to Segment and on to enabled cloud-mode destinations. We do not support sending data to bundled, device-mode integrations outside of Cocoapods.

Here are the steps for installing manually:

1. Add `analytics-ios` as a npm dependency: `yarn add @metarouter/analytics-ios@github:metarouter/analytics-ios#3.6.10`
2. In the `General` tab for your project, search for `Embedded Binaries` and add the `Analytics.framework`
   ![Embed Analytics.framework](https://segment.com/docs/sources/mobile/react-native/images/embed-analytics-framework.png)

Please note, if you are choosing to not use a dependency manager, you must keep files up-to-date with regularly scheduled, manual updates.

### "Failed to load [...] native module"

If you're getting a `Failed to load [...] native module` error, it means that some native code hasn't been injected to your native project.

#### iOS

If you're using Cocoapods, check that your `ios/Podfile` file contains the right pods :

- `Failed to load Analytics native module`, look for the core native module:
  ```ruby
  pod 'RNAnalytics', :path => '../node_modules/@metarouter/analytics-react-native'
  ```

Also check that your `Podfile` is synchronized with your workspace, run `pod install` in your `ios` folder.

If you're not using Cocoapods please check that you followed the [iOS support without CocoaPods](#ios-support-without-cocoapods) instructions carefully.

#### Android

Check that `android/app/src/main/.../MainApplication.java` contains a reference to the native module:

- `Failed to load Analytics native module`, look for the core native module:

  ```java
  import com.segment.analytics.reactnative.core.RNAnalyticsPackage;

  // ...

  @Override
  protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          // ...
          new RNAnalyticsPackage()
      );
  }
  ```

- `Failed to load [...] integration native module`, look for the integration native module, example with Google Analytics:

  ```java
  import com.segment.analytics.reactnative.integration.google.analytics.RNAnalyticsIntegration_Google_AnalyticsPackage;

  // ...

  @Override
  protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          // ...
          new RNAnalyticsIntegration_Google_AnalyticsPackage()
      );
  }
  ```
