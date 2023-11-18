import type {ViewProps} from 'ViewPropTypes';
import type {HostComponent} from 'react-native';
import codegenNativeComponent, {NativeComponentType} from 'react-native/Libraries/Utilities/codegenNativeComponent';
import {Float, DirectEventHandler, WithDefault} from "react-native/Libraries/Types/CodegenTypes";
import codegenNativeCommands from "react-native/Libraries/Utilities/codegenNativeCommands";

type ScrollEvent = Readonly<{
    x: Float;
    y: Float;
}>;

export interface NativeProps extends ViewProps {
    contentWidth: Float,
    bounces?: WithDefault<boolean, false>,
    showIndicator?: WithDefault<boolean, false>,
    onScroll: DirectEventHandler<ScrollEvent>,
    scrollEnable?: WithDefault<boolean, false>,
}

interface NativeCommands {
    setContentOffset: (
        viewRef: React.ElementRef<NativeComponentType<NativeProps>>,
        x: Float,
        y: Float,
    ) => void;
}

export const Commands: NativeCommands = codegenNativeCommands<NativeCommands>({
    supportedCommands: [
        'setContentOffset',
    ],
});

export default codegenNativeComponent<NativeProps>(
    'RNPageScrollView',
) as HostComponent<NativeProps>;
