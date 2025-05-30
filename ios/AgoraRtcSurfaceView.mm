#ifdef RCT_NEW_ARCH_ENABLED
#import "AgoraRtcSurfaceView.h"

#import <react/renderer/components/AgoraRtcNgSpec/ComponentDescriptors.h>
#import <react/renderer/components/AgoraRtcNgSpec/EventEmitters.h>
#import <react/renderer/components/AgoraRtcNgSpec/Props.h>
#import <react/renderer/components/AgoraRtcNgSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"
#import "AgoraRtcNg.h"
#import <AgoraRtcWrapper/iris_engine_base.h>

using namespace facebook::react;

@interface AgoraRtcSurfaceView () <RCTAgoraRtcSurfaceViewViewProtocol>

@end

@implementation AgoraRtcSurfaceView {
    UIView * _view;
    BOOL _isInitialized;
    BOOL _isDestroyed;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<AgoraRtcSurfaceViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        static const auto defaultProps = std::make_shared<const AgoraRtcSurfaceViewProps>();
        _props = defaultProps;

        _view = [[UIView alloc] init];
        _isInitialized = NO;
        _isDestroyed = NO;

        self.contentView = _view;
    }

    return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<AgoraRtcSurfaceViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<AgoraRtcSurfaceViewProps const>(props);

    if (_isDestroyed) {
        _isInitialized = NO;
        _isDestroyed = NO;
    }

    if (!_isInitialized || oldViewProps.callApi.funcName != newViewProps.callApi.funcName || oldViewProps.callApi.params != newViewProps.callApi.params) {
        char result[kBasicResultLength];
        void *buffers[1];
        buffers[0] = (__bridge void*)_view;
        ApiParam param = {
            .event = newViewProps.callApi.funcName.c_str(),
            .data = newViewProps.callApi.params.c_str(),
            .data_size = static_cast<unsigned int>(newViewProps.callApi.params.length()),
            .result = result,
            .buffer = buffers,
            .length = nullptr,
            .buffer_count = 1,
        };
        if ([[AgoraRtcNg shareInstance] irisApiEngine]) {
            [[AgoraRtcNg shareInstance] irisApiEngine]->CallIrisApi(&param);
        }
        _isInitialized = YES;
    }

    [super updateProps:props oldProps:oldProps];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _isDestroyed = YES;
}

Class<RCTComponentViewProtocol> AgoraRtcSurfaceViewCls(void)
{
    return AgoraRtcSurfaceView.class;
}

Class<RCTComponentViewProtocol> AgoraRtcTextureViewCls(void)
{
    return AgoraRtcSurfaceView.class;
}

@end
#endif
